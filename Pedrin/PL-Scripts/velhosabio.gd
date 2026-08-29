extends Interactable

@onready var caixa_dialogo = $"../CamadaDialogo/ColorRect"
@onready var texto_dialogo = $"../CamadaDialogo/ColorRect/Label"

var dialogo_aberto: bool = false

var dicas_diarias = {
	1: "Milhos no verão gostam de muita água.",
	2: "Milhos precisam de menos adubo no verão.",
	3: "Café no verão bebem pouca água.",
	4: "Cafés no frio crescem mais e bebem mais água.",
	5: "Os milhos no outono gostam de adubo.",
	6: "Quanto mais frio menos os milhos bebem água.",
	7: "O café no frio deve ser regada dia sim, dia não.",
	8: "O café não precisa de água, em vez disso precisa de adubo, se não morre.",
	9: "Para os milhos o equilíbrio é a chave.",
	10: "1 de cada já basta.",
	11: "Os milhos na primavera gostam de bastante água.",
	12: "3 fertilizantes são letais."
}

func _ready() -> void:
	caixa_dialogo.visible = false

func interagir() -> void:
	if dialogo_aberto:
		_fechar_dialogo()
	else:
		_abrir_dialogo()

func _abrir_dialogo() -> void:
	var dia_hoje = SistemaTempo.dia_atual
	
	var frase = "O tempo está louco hoje, não acha?"
	
	if dicas_diarias.has(dia_hoje):
		frase = dicas_diarias[dia_hoje]
		
	texto_dialogo.text = frase
	caixa_dialogo.visible = true
	dialogo_aberto = true

func _fechar_dialogo() -> void:
	caixa_dialogo.visible = false
	dialogo_aberto = false
