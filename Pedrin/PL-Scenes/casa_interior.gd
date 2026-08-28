extends Node2D
@onready var player = $PlayerTd/Player


func _ready() -> void:
	if Global.entrada_alvo != "":
		var spawn_carregado = get_node_or_null(Global.entrada_alvo)
		if spawn_carregado:
			player.global_position = spawn_carregado.global_position
		Global.entrada_alvo = ""
