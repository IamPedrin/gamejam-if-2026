extends Interactable

var estado_terra: String = "normal"
var tipo_semente_plantada: String = "" 
var agua_recebida: int = 0
var fertilizante_recebido: int = 0
var dias_vivos: int = 0 

@onready var sprite_terra = $Sprite2D
@onready var sprite_planta = $SpritePlanta 

var requisitos_sementes = {
	"Semente_1": {
		"Primavera": {"agua": 1, "fert": 0},
		"Verão":     {"agua": 1, "fert": 0},
		"Outono":    {"agua": 1, "fert": 0},
		"Inverno":   {"agua": 1, "fert": 0}
	},
	"Semente_2": {
		"Primavera": {"agua": 1, "fert": 0},
		"Verão":     {"agua": 1, "fert": 0}, 
		"Outono":    {"agua": 1, "fert": 0},
		"Inverno":   {"agua": 1, "fert": 0}  
	}
}

var texturas_plantas = {
	"Semente_1": [
		preload("res://Pedrin/PL-Sprites/Milhos/milhoSeed.tres"), 
		preload("res://Pedrin/PL-Sprites/Milhos/milho2.tres"),   
		preload("res://Pedrin/PL-Sprites/Milhos/milho3.tres"),   
		preload("res://Pedrin/PL-Sprites/Milhos/milho4.tres")   
	],
	"Semente_2": [
		preload("res://Pedrin/PL-Sprites/Cafes/cafeSeed.tres"),
		preload("res://Pedrin/PL-Sprites/Cafes/cafe2.tres"),
		preload("res://Pedrin/PL-Sprites/Cafes/cafe3.tres"),
		preload("res://Pedrin/PL-Sprites/Cafes/cafe4.tres")
	]
}

func _ready() -> void:
	add_to_group("canteiros") 
	
	if Global.estado_dos_canteiros.has(name):
		var mem = Global.estado_dos_canteiros[name]
		estado_terra = mem["estado"]
		tipo_semente_plantada = mem["semente"]
		agua_recebida = mem["agua"]
		fertilizante_recebido = mem["fert"]
		
		if mem.has("dias_vivos"):
			dias_vivos = mem["dias_vivos"]
			
	_atualizar_visuais()

func _salvar_estado() -> void:
	Global.estado_dos_canteiros[name] = {
		"estado": estado_terra,
		"semente": tipo_semente_plantada,
		"agua": agua_recebida,
		"fert": fertilizante_recebido,
		"dias_vivos": dias_vivos
	}

func _atualizar_visuais() -> void:
	# Reseta posição visual
	sprite_planta.position.y = 0

	if estado_terra == "normal":
		sprite_terra.modulate = Color("ffffff") 
	elif estado_terra == "arado" or estado_terra == "com_semente":
		sprite_terra.modulate = Color("6b4226")
		if agua_recebida > 0:
			sprite_terra.modulate = sprite_terra.modulate.darkened(0.2)
	elif estado_terra == "morta":
		sprite_terra.modulate = Color("1a1a1a")
		sprite_planta.visible = true
		sprite_planta.position.y = -10 # Sobe a planta morta
		sprite_planta.texture = preload("res://Pedrin/PL-Sprites/morte/mortePlanta.tres")

	if estado_terra == "com_semente" and texturas_plantas.has(tipo_semente_plantada):
		sprite_planta.visible = true
		sprite_planta.position.y = -10 # Sobe a planta viva
		
		var fase_atual = dias_vivos / 3 
		if fase_atual > 3:
			fase_atual = 3
			
		sprite_planta.texture = texturas_plantas[tipo_semente_plantada][fase_atual]
	elif estado_terra != "morta":
		sprite_planta.visible = false
		sprite_planta.texture = null

func interagir() -> void:
	var item_na_mao = Global.item_equipado
	var interagiu = false 
	
	# CORREÇÃO: Agora a enxada consegue limpar tanto a terra normal quanto a morta
	if item_na_mao == "Enxada" and (estado_terra == "normal" or estado_terra == "morta"):
		estado_terra = "arado"
		tipo_semente_plantada = ""
		agua_recebida = 0
		fertilizante_recebido = 0
		dias_vivos = 0
		interagiu = true
		
	elif requisitos_sementes.has(item_na_mao) and estado_terra == "arado":
		if Global.qtd_sementes[item_na_mao] > 0:
			Global.qtd_sementes[item_na_mao] -= 1
			estado_terra = "com_semente"
			tipo_semente_plantada = item_na_mao
			dias_vivos = 0 
			interagiu = true
			
	elif item_na_mao == "Regador" and estado_terra == "com_semente":
		agua_recebida += 1
		interagiu = true
		
	elif item_na_mao == "Fertilizante" and estado_terra == "com_semente":
		fertilizante_recebido += 1
		interagiu = true

	if interagiu:
		_atualizar_visuais()
		_salvar_estado()
