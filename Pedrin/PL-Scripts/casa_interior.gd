extends Node2D

@onready var player = $PlayerTd

func _ready() -> void:
	if Global.entrada_alvo != "":
		# find_child procura em todos os níveis e pastas da cena
		var spawn_carregado = find_child(Global.entrada_alvo, true, false)
		
		if spawn_carregado: 
			player.global_position = spawn_carregado.global_position
		
		Global.entrada_alvo = ""

	SistemaTempo.meia_noite.connect(_desmaiar_na_casa)

func _desmaiar_na_casa() -> void:
	Global.dormir_e_processar_dia(get_tree())
