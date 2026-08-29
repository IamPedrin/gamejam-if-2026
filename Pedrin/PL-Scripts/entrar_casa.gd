extends Area2D

@export_file ("*.tscn") var cena_caminho: String
@export var spawn_destino: String

func _on_body_entered(body: Node2D) -> void:
	if body.name == "PlayerTd":
		if cena_caminho != "":
			Global.entrada_alvo = spawn_destino
			
			# O Godot agora vai agendar a troca de cena para a fração de segundo 
			# seguinte, após terminar de calcular a colisão com segurança.
			get_tree().call_deferred("change_scene_to_file", cena_caminho)
			
		else:
			print("Conecte no inspector a cena")
	else:
		print("Não é o player")
