extends Node2D

var itens = {
	"Enxada": {
		"tipo": "ferramenta",
		"estocavel": false,
		"max_qtd": 1,
		"textura": preload("res://Pedrin/PL-Sprites/enxada.tres")
	},
	"Regador": {
		"tipo": "ferramenta",
		"estocavel": false,
		"max_qtd": 1,
		"capacidade_agua": 10, # Sistema de encher o regador
		"agua_atual": 0,
		"textura": preload("res://Pedrin/PL-Sprites/WateringCan.png")
	},
	"Semente_1": {
		"tipo": "semente",
		"estocavel": true,
		"max_qtd": 99,
		#"cena_planta": preload("res://plantas/tomate.tscn"), # O que vai nascer
		"textura": preload("res://Pedrin/PL-Sprites/milho.tres")
	},
	
	"Semente_2": {
		"tipo": "semente",
		"estocavel": true,
		"max_qtd": 99,
		#"cena_planta": preload("res://plantas/tomate.tscn"), # O que vai nascer
		"textura": preload("res://Pedrin/PL-Sprites/cafee.tres")
	},
	"Fertilizante": {
		"tipo": "fertilizante",
		"estocavel": true,
		"max_qtd": 99,
		#"cena_planta": preload("res://plantas/tomate.tscn"), # O que vai nascer
		"textura": preload("res://Pedrin/PL-Sprites/fertilizante.tres")
	}
}
