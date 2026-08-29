extends CanvasLayer

func _on_tryagain_pressed() -> void:
	SistemaTempo.dia_atual = 1
	SistemaTempo.tempo_passado = 0
	SistemaTempo.relogio_rodando = true
	Global.qtd_sementes = {"Semente_1": 3, "Semente_2": 3}
	Global.estado_dos_canteiros.clear()
	Global.entrada_alvo = ""
	
	get_tree().change_scene_to_file("res://Pedrin/PL-Scenes/Fazenda.tscn")
