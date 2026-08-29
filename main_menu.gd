extends Control

@export_file("*.tscn") var cena_do_jogo: String

func _ready() -> void:
	var main_buttons = get_node_or_null("MainButtons")
	var options = get_node_or_null("Panel")
	var slider = get_node_or_null("Panel/HSlider")

	print("MainButtons encontrado: ", main_buttons != null)
	print("Panel encontrado: ", options != null)
	print("HSlider encontrado: ", slider != null)

	if main_buttons:
		main_buttons.visible = true

	if options:
		options.visible = false

	if slider:
		slider.mouse_filter = Control.MOUSE_FILTER_STOP

	print("MainButtons encontrado: ", main_buttons != null)
	print("Panel encontrado: ", options != null)

	if main_buttons:
		main_buttons.visible = true

	if options:
		options.visible = false


func _on_playbutton_pressed() -> void:
	if cena_do_jogo != "":
		get_tree().change_scene_to_file(cena_do_jogo)
	else:
		print("Aviso: Selecione a cena do jogo no Inspetor!")


func _on_optionsbutton_pressed() -> void:
	var main_buttons = get_node_or_null("MainButtons")
	var options = get_node_or_null("Panel")

	if main_buttons:
		main_buttons.visible = false

	if options:
		options.visible = true


func _on_quitbutton_pressed() -> void:
	get_tree().quit()


func _on_back_button_pressed() -> void:
	var main_buttons = get_node_or_null("MainButtons")
	var options = get_node_or_null("Panel")

	if main_buttons:
		main_buttons.visible = true

	if options:
		options.visible = false
