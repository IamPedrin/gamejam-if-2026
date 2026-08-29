extends Control

@export_file("*.tscn") var cena_do_jogo : String

func _on_playbutton_pressed() -> void:
	if cena_do_jogo != "":
		get_tree().change_scene_to_file(cena_do_jogo)
	else:
		print("Aviso: Selecione a cena do jogo no Inspetor!")

func _on_optionsbutton_pressed() -> void:
	print("Menu de opções clicado!")

func _on_quitbutton_pressed() -> void:
	get_tree().quit() # Fecha o jogo
