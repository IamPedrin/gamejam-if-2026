extends Node

var entrada_alvo: String = ""
var item_equipado: String = ""
var jogador_travado: bool = false

var qtd_sementes = {
	"Semente_1": 3,
	"Semente_2": 3
}

var estado_dos_canteiros: Dictionary = {}

func dormir_e_processar_dia(arvore_de_cenas: SceneTree) -> void:
	SistemaTempo.avancar_dia()
	var dia = SistemaTempo.dia_atual
	var estacao = SistemaTempo.obter_estacao_atual()
	
	var plantas_vivas = 0

	for nome_canteiro in estado_dos_canteiros.keys():
		var mem = estado_dos_canteiros[nome_canteiro]
		
		if mem["estado"] == "com_semente":
			var semente = mem["semente"]
			var req_agua = 0
			var req_fert = 0
			
			if semente == "Semente_1":
				req_agua = 1; req_fert = 0
			elif semente == "Semente_2":
				req_agua = 1; req_fert = 0

			# CORREÇÃO: Usa >= para que excessos acidentais não matem a planta
			if mem["agua"] >= req_agua and mem["fert"] >= req_fert:
				plantas_vivas += 1
				if not mem.has("dias_vivos"):
					mem["dias_vivos"] = 0
				mem["dias_vivos"] += 1 
			else:
				mem["estado"] = "morta"
				mem["semente"] = ""
				mem["dias_vivos"] = 0
				
		mem["agua"] = 0
		mem["fert"] = 0

	if dia == 2:
		qtd_sementes["Semente_1"] = 0
		qtd_sementes["Semente_2"] = 0

	if dia > 12:
		arvore_de_cenas.change_scene_to_file("res://Pedrin/PL-Scenes/TelaVitoria.tscn")
		return
		
	if dia >= 2 and plantas_vivas == 0:
		arvore_de_cenas.change_scene_to_file("res://Pedrin/PL-Scenes/TelaGameOver.tscn")
		return

	entrada_alvo = "SpawnCama"
	arvore_de_cenas.change_scene_to_file("res://Pedrin/PL-Scenes/CasaInterior.tscn")
