extends Node
var entrada_alvo: String = ""
var item_equipado: String = ""

var qtd_sementes = {
	"Semente_1": 3,
	"Semente_2": 3
}

var estado_dos_canteiros: Dictionary = {}

# Essa função centraliza TUDO sobre virar a noite
func dormir_e_processar_dia(arvore_de_cenas: SceneTree) -> void:
	SistemaTempo.avancar_dia()
	var dia = SistemaTempo.dia_atual
	var estacao = SistemaTempo.obter_estacao_atual()
	
	var plantas_vivas = 0

	# 1. PROCESSA A MEMÓRIA DIRETAMENTE (Funciona mesmo dentro de casa!)
	for nome_canteiro in estado_dos_canteiros.keys():
		var mem = estado_dos_canteiros[nome_canteiro]
		
		if mem["estado"] == "com_semente":
			var semente = mem["semente"]
			var req_agua = 0
			var req_fert = 0
			
			if semente == "Semente_1":
				if estacao == "Primavera": req_agua = 1; req_fert = 0
				elif estacao == "Verão": req_agua = 1; req_fert = 0
				elif estacao == "Outono": req_agua = 1; req_fert = 0
				elif estacao == "Inverno": req_agua = 1; req_fert = 0
			elif semente == "Semente_2":
				if estacao == "Primavera": req_agua = 1; req_fert = 0
				elif estacao == "Verão": req_agua = 1; req_fert = 0
				elif estacao == "Outono": req_agua = 1; req_fert = 0
				elif estacao == "Inverno": req_agua = 1; req_fert = 0

			# Julga sobrevivência
			if mem["agua"] == req_agua and mem["fert"] == req_fert:
				plantas_vivas += 1
			else:
				mem["estado"] = "morta"
				mem["semente"] = ""
				
		# Zera a água e adubo para o dia seguinte
		mem["agua"] = 0
		mem["fert"] = 0

	# 2. Faz as sementes sumirem no Dia 2
	if dia == 2:
		qtd_sementes["Semente_1"] = 0
		qtd_sementes["Semente_2"] = 0

	# 3. CONDIÇÕES DE TELA
	if dia > 12:
		arvore_de_cenas.change_scene_to_file("res://Pedrin/PL-Scenes/TelaVitoria.tscn")
		return
		
	if dia >= 2 and plantas_vivas == 0:
		arvore_de_cenas.change_scene_to_file("res://Pedrin/PL-Scenes/TelaGameOver.tscn")
		return

	# 4. Se sobreviveu, acorda normalmente
	entrada_alvo = "SpawnCama"
	arvore_de_cenas.change_scene_to_file("res://Pedrin/PL-Scenes/CasaInterior.tscn")
