extends Node2D

var dados_dos_itens = {
	"enxada": {
		"tipo": "ferramenta",
		"estocavel": false,
		"max_qtd": 1,
		#"textura": preload("res://sprites/enxada.png")
	},
	"regador": {
		"tipo": "ferramenta",
		"estocavel": false,
		"max_qtd": 1,
		"capacidade_agua": 10, # Sistema de encher o regador
		"agua_atual": 0,
		#"textura": preload("res://sprites/regador.png")
	},
	"semente_1": {
		"tipo": "semente",
		"estocavel": true,
		"max_qtd": 99,
		#"cena_planta": preload("res://plantas/tomate.tscn"), # O que vai nascer
		#"textura": preload("res://sprites/semente_tomate.png")
	},
	
	"semente_2": {
		"tipo": "semente",
		"estocavel": true,
		"max_qtd": 99,
		#"cena_planta": preload("res://plantas/tomate.tscn"), # O que vai nascer
		#"textura": preload("res://sprites/semente_tomate.png")
	},
		"Fertilizante": {
		"tipo": "fertilizante",
		"estocavel": true,
		"max_qtd": 99,
		#"cena_planta": preload("res://plantas/tomate.tscn"), # O que vai nascer
		#"textura": preload("res://sprites/semente_tomate.png")
	}
}
