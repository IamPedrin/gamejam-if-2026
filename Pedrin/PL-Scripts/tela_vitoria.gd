extends CanvasLayer

@onready var estatisticas = $Estatisticas

func _ready() -> void:
	var plantas_vivas = 0
	
	# Conta na memória do Global quantas plantas chegaram vivas no último dia
	for nome_canteiro in Global.estado_dos_canteiros.keys():
		if Global.estado_dos_canteiros[nome_canteiro]["estado"] == "com_semente":
			plantas_vivas += 1

	# Personaliza a mensagem baseada no desempenho
	if plantas_vivas >= 6:
		estatisticas.text = "Todas as " + str(plantas_vivas) + " plantas chegaram à fase adulta!"
	else:
		estatisticas.text = "Parabéns!\nVocê sobreviveu 1 ano e salvou " + str(plantas_vivas) + " plantas."

func _on_tryagain_pressed() -> void:
		# Reseta absolutamente tudo para o jogo recomeçar limpo
	SistemaTempo.dia_atual = 1
	SistemaTempo.tempo_passado = 0
	SistemaTempo.relogio_rodando = true
	Global.qtd_sementes = {"Semente_1": 3, "Semente_2": 3}
	Global.estado_dos_canteiros.clear()
	Global.entrada_alvo = ""
	
	get_tree().change_scene_to_file("res://main_menu.tscn")
