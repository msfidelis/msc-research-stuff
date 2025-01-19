package main

import (
	"app/pkg/setup"
	"app/pkg/sharding"
	"io"
	"log"
	"net/http"
	"net/url"
	"os"
)

func main() {

	setup.Init()

	proxyHandler := func(w http.ResponseWriter, r *http.Request) {

		shardKey := sharding.GetShardingKey(r)
		shardURL := sharding.GetShardHost(shardKey)
		targetURL, err := url.Parse(shardURL + r.URL.Path)
		if err != nil {
			http.Error(w, "Invalid target URL", http.StatusBadRequest)
			return
		}

		proxyReq, err := http.NewRequest(r.Method, targetURL.String(), r.Body)
		if err != nil {
			http.Error(w, "Failed to create request", http.StatusInternalServerError)
			return
		}
		proxyReq.Header = r.Header

		client := &http.Client{}
		resp, err := client.Do(proxyReq)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadGateway)
			return
		}
		defer resp.Body.Close()

		for k, v := range resp.Header {
			w.Header()[k] = v
		}
		w.WriteHeader(resp.StatusCode)
		io.Copy(w, resp.Body)
	}

	// Inicia o servidor
	http.HandleFunc("/", proxyHandler)
	port := os.Getenv("ROUTER_PORT")
	log.Printf("HTTP Proxy running on port %s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
