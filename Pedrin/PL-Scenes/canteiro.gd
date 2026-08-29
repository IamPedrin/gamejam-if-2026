extends Interactable

var estado_terra: String = "normal"
var tipo_semente_plantada: String = "" 
var agua_recebida: int = 0
var fertilizante_recebido: int = 0

@onready var sprite = $Sprite2D

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

func _ready() -> void:
	add_to_group("canteiros") 
	SistemaTempo.dia_mudou.connect(_processar_fim_de_dia)
	
	# 1. CARREGAR A MEMÓRIA: Procura no Global pelo nome exato deste canteiro
	if Global.estado_dos_canteiros.has(name):
		var mem = Global.estado_dos_canteiros[name]
		estado_terra = mem["estado"]
		tipo_semente_plantada = mem["semente"]
		agua_recebida = mem["agua"]
		fertilizante_recebido = mem["fert"]
		
	_atualizar_cores()

# 2. SALVAR A MEMÓRIA: Atualiza o Global com os dados atuais
func _salvar_estado() -> void:
	Global.estado_dos_canteiros[name] = {
		"estado": estado_terra,
		"semente": tipo_semente_plantada,
		"agua": agua_recebida,
		"fert": fertilizante_recebido
	}

func _atualizar_cores() -> void:
	if estado_terra == "normal":
		sprite.modulate = Color("ffffff") # Cor base original
	elif estado_terra == "arado":
		sprite.modulate = Color("6b4226")
	elif estado_terra == "morta":
		sprite.modulate = Color("1a1a1a")
	elif estado_terra == "com_semente":
		if tipo_semente_plantada == "Semente_1":
			sprite.modulate = Color("e5e542")
		elif tipo_semente_plantada == "Semente_2":
			sprite.modulate = Color("ff6347")
			
		if agua_recebida > 0:
			sprite.modulate = sprite.modulate.darkened(0.2)

func interagir() -> void:
	var item_na_mao = Global.item_equipado
	var interagiu = false # Avisa se fizemos algo válido para não salvar à toa
	
	if item_na_mao == "Enxada" and estado_terra == "normal":
		estado_terra = "arado"
		interagiu = true
		print("Terra arada!")
		
	elif requisitos_sementes.has(item_na_mao) and estado_terra == "arado":
		if Global.qtd_sementes[item_na_mao] > 0:
			Global.qtd_sementes[item_na_mao] -= 1
			estado_terra = "com_semente"
			tipo_semente_plantada = item_na_mao
			interagiu = true
			print(item_na_mao, " plantada! Restam: ", Global.qtd_sementes[item_na_mao])
		else:
			print("Você não tem mais dessa semente!")
			
	elif item_na_mao == "Regador" and estado_terra == "com_semente":
		agua_recebida += 1
		interagiu = true
		print("Planta regada! Água hoje: ", agua_recebida)
		
	elif item_na_mao == "Fertilizante" and estado_terra == "com_semente":
		fertilizante_recebido += 1
		interagiu = true
		print("Fertilizante aplicado! Total hoje: ", fertilizante_recebido)

	# Se a ação deu certo, atualiza a cor e envia pra memória no mesmo milissegundo
	if interagiu:
		_atualizar_cores()
		_salvar_estado()

func _processar_fim_de_dia(dia: int, estacao: String) -> void:
	if estado_terra == "com_semente":
		var regras = requisitos_sementes[tipo_semente_plantada][estacao]
		
		if agua_recebida == regras["agua"] and fertilizante_recebido == regras["fert"]:
			print("Seu(sua) ", tipo_semente_plantada, " sobreviveu à noite!")
		else:
			estado_terra = "morta"
			tipo_semente_plantada = ""
			print("A planta secou e morreu...")
			
	# Zera os cuidados para o dia seguinte
	agua_recebida = 0
	fertilizante_recebido = 0
	
	# Atualiza as cores e SALVA ANTES de a cena trocar
	_atualizar_cores()
	_salvar_estado()
