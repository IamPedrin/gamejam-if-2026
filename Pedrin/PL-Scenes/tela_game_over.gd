extends CanvasLayer

func _on_button_pressed() -> void:
	SistemaTempo.dia_atual = 1
	SistemaTempo.tempo_passado = 0
	SistemaTempo.relogio_rodando = true
	Global.qtd_sementes = {"Semente_1": 3, "Semente_2": 3}
	
	get_tree().change_scene_to_file("res://Pedrin/PL-Scenes/Fazenda.tscn")
