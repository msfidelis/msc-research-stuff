package clientes

import (
	"main/dto"
	"main/pkg/database"
	"main/services"
	"time"

	"github.com/gofiber/fiber/v2"
)

func Extrato(c *fiber.Ctx) error {

	id := string(c.Request().Header.Peek("id_client"))

	db := database.GetDB()

	cliente, err := services.BuscaCliente(c.Context(), db, id)
	if err != nil {
		return dto.FiberError(c, fiber.StatusInternalServerError, "Erro ao recuperar o cliente")
	}

	transacoes, err := services.Extrato(id)
	if err != nil {
		return dto.FiberError(c, fiber.StatusInternalServerError, "Erro ao recuperar as transações")
	}

	response := dto.ExtratoResponse{
		UltimasTransacoes: transacoes,
	}

	response.Saldo.Total = cliente.Saldo
	response.Saldo.Limite = cliente.Limite
	response.Saldo.DataExtrato = time.Now().UTC().Format(time.RFC3339Nano)

	return c.JSON(response)

}
