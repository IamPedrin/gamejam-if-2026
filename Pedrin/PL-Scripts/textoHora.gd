extends Label

@onready var texto_calendario = $"../TextoCalendario"

func _ready() -> void:
	SistemaTempo.tempo_atualizado.connect(_atualizar_texto)
	SistemaTempo.dia_mudou.connect(_atualizar_calendario)
	
	# Força a atualização do texto do calendário assim que o jogo abre
	_atualizar_calendario(SistemaTempo.dia_atual, SistemaTempo.obter_estacao_atual())

func _atualizar_texto(hora: int, minuto: int) -> void:
	text = "%02d:%02d" % [hora, minuto]

func _atualizar_calendario(dia: int, estacao: String) -> void:
	texto_calendario.text = "Dia " + str(dia) + " - " + estacao
