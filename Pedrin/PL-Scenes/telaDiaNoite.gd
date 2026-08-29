extends CanvasModulate

@export var cor_manha: Color = Color("ffffff")
@export var cor_tarde: Color = Color("ffaa55") # Laranja de pôr do sol
@export var cor_noite: Color = Color("111133") # Azul escuro

func _process(_delta: float) -> void:
	var fracao = SistemaTempo.fracao_dia
	
	if fracao <= 0.5:
		var peso = fracao / 0.5
		color = cor_manha.lerp(cor_tarde, peso)
	else:
		var peso = (fracao - 0.5) / 0.5
		color = cor_tarde.lerp(cor_noite, peso)
