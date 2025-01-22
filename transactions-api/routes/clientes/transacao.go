package clientes

import (
	"fmt"
	"main/dto"
	"main/entities"
	"main/services"
	"time"

	"github.com/gofiber/fiber/v2"
)

var functionName = "NovaTransacao"

var request dto.TransacaoRequest

var saldo int64
var limite int64
var semLimite bool
var err error

func NovaTransacao(c *fiber.Ctx) error {

	id := string(c.Request().Header.Peek("id_client"))

	// Parser do Request
	if err := c.BodyParser(&request); err != nil {
		return dto.FiberError(c, fiber.StatusBadRequest, err.Error())
	}

	fmt.Println(request)

	transacao := &entities.Transacao{
		IDCliente:   id,
		Tipo:        request.Tipo,
		Valor:       request.Valor,
		Descricao:   request.Descricao,
		RealizadaEm: time.Now().UTC().Format(time.RFC3339Nano),
	}

	saldo, limite, semLimite, err = services.Crebito(*transacao)

	if semLimite {
		return dto.FiberError(c, fiber.StatusUnprocessableEntity, "cliente sem limite disponível")
	}

	if err != nil {
		return dto.FiberError(c, fiber.StatusInternalServerError, err.Error())
	}

	fmt.Printf("[%v] Cliente: %v\n", c.Context().ID(), id)
	fmt.Printf("[%v] Tipo: %v\n", c.Context().ID(), request.Tipo)
	fmt.Printf("[%v] Valor: %v\n", c.Context().ID(), request.Valor)
	fmt.Printf("[%v] Descricao: %v\n", c.Context().ID(), request.Descricao)
	fmt.Printf("[%v] Saldo: %v\n", c.Context().ID(), saldo)
	fmt.Printf("[%v] Limite: %v\n", c.Context().ID(), limite)

	response := dto.TransacaoResponse{
		Limite: limite,
		Saldo:  saldo,
	}
	return c.Status(fiber.StatusOK).JSON(response)
}
