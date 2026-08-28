extends Area2D

@export_file ("*.tscn") var cena_caminho: String
@export var spawn_destino: String


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if cena_caminho != "":
			Global.entrada_alvo = spawn_destino
			get_tree().change_scene_to_file(cena_caminho)
		else:
			print("Conecte no inspector a cena")
	else:
		print("Não é o player")
