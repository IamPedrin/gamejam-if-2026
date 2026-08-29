extends Node2D

@onready var player = $PlayerTd/Player
@onready var tela_escura = $CanvasLayer/ColorRect 

func _ready() -> void:
	if Global.entrada_alvo == "":
		var spawn_inicial = get_node_or_null("SpawnPoint")
		if spawn_inicial: player.global_position = spawn_inicial.global_position
	else:
		var spawn_carregado = get_node_or_null(Global.entrada_alvo)
		if spawn_carregado: player.global_position = spawn_carregado.global_position
		Global.entrada_alvo = ""

	# Conecta o sinal da meia-noite
	SistemaTempo.meia_noite.connect(_desmaiar_meia_noite)

func _desmaiar_meia_noite() -> void:
	var tween = create_tween()
	# Faz o ColorRect ir do Alpha 0 (transparente) para 1 (preto sólido) em 2 segundos
	tween.tween_property(tela_escura, "modulate:a", 1.0, 2.0)
	
	# Quando o fade terminar, chama a função de trocar de cena
	tween.tween_callback(_acordar_na_casa)

func _acordar_na_casa() -> void:
	Global.entrada_alvo = "SpawnCama" 
	
	# 1. Avança o dia (os canteiros vão julgar se vivem ou morrem sozinhos aqui)
	SistemaTempo.avancar_dia()
	
	# 2. A Fazenda atua como juiz IMEDIATAMENTE após os canteiros decidirem
	var plantas_vivas = 0
	for canteiro in get_tree().get_nodes_in_group("canteiros"):
		if canteiro.estado_terra == "com_semente":
			plantas_vivas += 1

	var dia = SistemaTempo.dia_atual

	# Faz as sementes sumirem do inventário no Dia 2
	if dia == 2:
		Global.qtd_sementes["Semente_Milho"] = 0
		Global.qtd_sementes["Semente_Tomate"] = 0
		print("As sementes não plantadas sumiram do seu inventário!")

	# 3. Verifica as condições FINAIS antes de trocar de cena
	if dia > 12:
		print("VITÓRIA! Você sobreviveu o ano com ", plantas_vivas, " plantas.")
		# Quando criar a cena de vitória, descomente e ajuste o caminho abaixo:
		# get_tree().change_scene_to_file("res://Pedrin/PL-Scenes/TelaVitoria.tscn")
		return # Para a execução do código aqui
		
	elif dia >= 2 and plantas_vivas == 0:
		print("GAME OVER! Sua fazenda faliu.")
		get_tree().change_scene_to_file("res://Pedrin/PL-Scenes/TelaGameOver.tscn")
		return # Para a execução do código aqui (impede que ele vá para a casa)

	# 4. Se não deu Game Over e nem Vitória, ele vai para a casa normalmente
	get_tree().change_scene_to_file("res://Pedrin/PL-Scenes/CasaInterior.tscn")
