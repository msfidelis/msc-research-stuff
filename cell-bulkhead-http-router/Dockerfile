FROM golang:1.23 AS builder

WORKDIR /app

COPY ./ .

RUN go mod tidy

RUN go build -o main .

FROM fidelissauro/apko-run:latest-arm64

WORKDIR /root/

COPY --from=builder /app/main .

CMD ["./main"]