extends Node2D

@onready var player = $PlayerTd/Player
@onready var tela_escura = $CanvasLayer/ColorRect 

func _ready() -> void:

	if Global.entrada_alvo == "":
		var spawn_inicial = get_node_or_null("SpawnPoint")
		if spawn_inicial: player.global_position = spawn_inicial.global_position
	else:
		var spawn_carregado = get_node_or_null(Global.entrada_alvo)
		if spawn_carregado: player.global_position = spawn_carregado.global_position
		Global.entrada_alvo = ""

	# Conecta o sinal da meia-noite
	SistemaTempo.meia_noite.connect(_desmaiar_meia_noite)

func _desmaiar_meia_noite() -> void:
	var tween = create_tween()
	# Faz o ColorRect ir do Alpha 0 (transparente) para 1 (preto sólido) em 2 segundos
	tween.tween_property(tela_escura, "modulate:a", 1.0, 2.0)
	
	# Quando o fade terminar, chama a função de trocar de cena
	tween.tween_callback(_acordar_na_casa)

func _acordar_na_casa() -> void:
	Global.entrada_alvo = "SpawnCama" # Crie um Marker2D na casa perto da cama com esse nome
	SistemaTempo.resetar_dia() # Reinicia o relógio para as 7h
	get_tree().change_scene_to_file("res://Pedrin/PL-Scenes/CasaInterior.tscn")
