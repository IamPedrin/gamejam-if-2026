extends Interactable

@onready var caixa_dialogo = $"../CamadaDialogo/ColorRect"
@onready var texto_dialogo = $"../CamadaDialogo/ColorRect/Label"

var dialogo_aberto: bool = false

var dicas_diarias = {
	1: "Tomatuxos no verão gostam de muita água.",
	2: "Tomatuxos precisam de menos adubo no verão.",
	3: "Sojentas no verão bebem pouca água.",
	4: "sojentas no frio crescem mais e bebem mais água.",
	5: "Os Tomatuxos no outono gostam de adubo.",
	6: "Quanto mais frio menos os Tomatuxos bebm água.",
	7: "As Sojentas no frio devem ser regadas dia sim dia não.",
	8: "As sojentas não bebem água ao invés disso precisam de adubo se não morrem.",
	9: "Para os Tomatuxos o equilíbrio é a chave.",
	10: "1 de cadajá basta.",
	11: "os Tomatuxos na primavera gostam de bastante água.",
	12: "3 Sojentas são letais."
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
