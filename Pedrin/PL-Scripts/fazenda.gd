extends Node2D

@onready var player = $PlayerTd
@onready var tela_escura = $CanvasLayer/ColorRect 

func _ready() -> void:
	if Global.entrada_alvo == "":
		var spawn_inicial = get_node_or_null("SpawnPoint")
		if spawn_inicial: player.global_position = spawn_inicial.global_position
	else:
		var spawn_carregado = get_node_or_null(Global.entrada_alvo)
		if spawn_carregado: player.global_position = spawn_carregado.global_position
		Global.entrada_alvo = ""

	SistemaTempo.meia_noite.connect(_desmaiar_meia_noite)

func _desmaiar_meia_noite() -> void:
	var tween = create_tween()
	tween.tween_property(tela_escura, "modulate:a", 1.0, 2.0)
	tween.tween_callback(_acordar_na_casa)

func _acordar_na_casa() -> void:
	# CORREÇÃO: Transfere toda a responsabilidade de virar a noite para o Global
	# Isso evita que o desmaio quebre a matemática das plantas
	Global.dormir_e_processar_dia(get_tree())
