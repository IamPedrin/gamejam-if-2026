extends Label

func _ready() -> void:
	SistemaTempo.tempo_atualizado.connect(_atualizar_texto)

func _atualizar_texto(hora: int, minuto: int) -> void:
	text = "%02d:%02d" % [hora, minuto]
