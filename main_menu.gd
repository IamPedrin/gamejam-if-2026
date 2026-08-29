extends Control

@onready var painel_creditos = $PainelCreditos
@onready var sound: AudioStreamPlayer2D = $sound
@onready var sound_main: AudioStreamPlayer = $sound_main

func _ready() -> void:
	# Garante de forma extra que os créditos não apareçam ao iniciar o jogo
	if painel_creditos:
		painel_creditos.visible = false
	
	sound_main.play()

# --- Funções dos Botões Principais ---

func _on_iniciar_pressed() -> void:
	# Reinicia o estado do tempo e inventário para um novo jogo limpo
	SistemaTempo.dia_atual = 1
	SistemaTempo.tempo_passado = 0
	SistemaTempo.relogio_rodando = true
	Global.estado_dos_canteiros.clear()
	
	# Carrega a cena do jogo (confirme se o caminho está exato)
	get_tree().change_scene_to_file("res://Pedrin/PL-Scenes/explicacao.tscn")

func _on_creditos_pressed() -> void:
	sound_main.stop()
	sound.play()
	painel_creditos.visible = true

func _on_sair_pressed() -> void:
	get_tree().quit()

# --- Função do Botão de Fechar os Créditos ---

func _on_botao_fechar_pressed() -> void:
	sound.stop()
	sound_main.play()
	painel_creditos.visible = false
