extends Node2D

@onready var player = $PlayerTd

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.entrada_alvo == "":
		var spawn_inicial = get_node_or_null("SpawnPoint")
		if spawn_inicial:
			player.global_position = spawn_inicial.global_position
	else:
		var spawn_carregado = get_node_or_null(Global.entrada_alvo)
		if spawn_carregado:
			player.global_position = spawn_carregado.global_position
		
		Global.entrada_alvo = ""
