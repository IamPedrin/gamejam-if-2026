extends Label

@export var velocidade: float = 50.0
@export var espera: float = 1.0

var tempo_espera := 0.0
var rolando := false

func _ready():
	position.y = get_viewport_rect().size.y
	tempo_espera = espera

func _process(delta):
	if not rolando:
		tempo_espera -= delta
		
		if tempo_espera <= 0:
			rolando = true
	else:
		position.y -= velocidade * delta
		
		if position.y + size.y < 0:
			position.y = get_viewport_rect().size.y
			tempo_espera = espera
			rolando = false
