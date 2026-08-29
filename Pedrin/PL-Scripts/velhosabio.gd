extends Interactable

@onready var caixa_dialogo = $"../CamadaDialogo/ColorRect"
@onready var texto_dialogo = $"../CamadaDialogo/ColorRect/Label"

var dialogo_aberto: bool = false

var dicas_diarias = {
	1: "Olá, jovem! O Milho mal precisa de água na Primavera, mas o Tomate já exige mais cuidado.",
	2: "Sementes não plantadas no primeiro dia apodrecem. Espero que tenha usado as suas!",
	3: "Amanhã o Verão começa! Prepare o regador, pois o sol castiga as plantas.",
	4: "Chegou o Verão! Os tomates vão precisar de 3 regadas diárias e 2 porções de fertilizante.",
	5: "Dica de ouro: regue e adube logo de manhã para não esquecer.",
	6: "O Outono se aproxima. O clima vai esfriar um pouco e a sede das plantas vai diminuir.",
	7: "Folhas caindo... No Outono, o Tomate nem precisa de fertilizante, apenas água.",
	8: "Fique de olho na cor da terra para saber se você já a regou hoje.",
	9: "O Inverno chega amanhã! O frio extremo exige que você adube muito a terra para mantê-la quente.",
	10: "No Inverno o Milho não precisa de água, mas consome muito fertilizante!",
	11: "Falta pouco para o fim do ano! Mantenha o foco nos cuidados diários.",
	12: "Último dia! Faça sua ronda final. Amanhã avaliaremos o sucesso da sua colheita."
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
