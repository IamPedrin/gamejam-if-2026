extends Node

@onready var minha_imagem: Sprite2D = $imagem
@onready var seletor: ColorRect = $seletor

# Posição do seletor
var coluna_atual: int = 0  
var linha_atual: int = 0   

# Configuração visual do alinhamento
var tamanho_da_casinha_x: float = 40.0  
var tamanho_da_casinha_y: float = 40.0  
var posicao_inicial: Vector2 = Vector2(0, 0)

# 🎒 INVENTÁRIO DINÂMICO (Começa totalmente vazio!)
var grade_de_itens: Array = []

func _ready() -> void:
	posicao_inicial = seletor.position
	seletor.visible = minha_imagem.visible
	
	# Cria a grade 7x4 vazia automaticamente ao iniciar o jogo
	limpar_inventario()
	
	adicionar_item_na_marra("Foice")
	adicionar_item_na_marra("Sementes")
	adicionar_item_na_marra("Regador")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mochila"):
		minha_imagem.visible = not minha_imagem.visible
		seletor.visible = minha_imagem.visible
	
	if minha_imagem.visible:
		if event.is_action_pressed("ui_right"):
			coluna_atual = (coluna_atual + 1) % 7
			atualizar_posicao_do_seletor()
		if event.is_action_pressed("ui_left"):
			coluna_atual = (coluna_atual - 1 + 7) % 7
			atualizar_posicao_do_seletor()
		if event.is_action_pressed("ui_down"):
			linha_atual = (linha_atual + 1) % 4
			atualizar_posicao_do_seletor()
		if event.is_action_pressed("ui_up"):
			linha_atual = (linha_atual - 1 + 4) % 4
			atualizar_posicao_do_seletor()
			
		# Selecionar/Usar o item
		if event.is_action_pressed("ui_accept"):
			verificar_item_na_casinha()

func atualizar_posicao_do_seletor() -> void:
	var novo_x = posicao_inicial.x + (coluna_atual * tamanho_da_casinha_x)
	var novo_y = posicao_inicial.y + (linha_atual * tamanho_da_casinha_y)
	seletor.position = Vector2(novo_x, novo_y)

# 🛠️ FUNÇÃO: Lê dinamicamente o que estiver guardado naquela casinha
func verificar_item_na_casinha() -> void:
	var item_atual = grade_de_itens[linha_atual][coluna_atual]
	if item_atual == "Vazio":
		print("Esta casinha está vazia!")
	else:
		print("Você selecionou o item real: ", item_atual)

# 🛠️ FUNÇÃO: Cria a grade limpa
func limpar_inventario() -> void:
	grade_de_itens = []
	for l in range(4):
		var linha = []
		for c in range(7):
			linha.append("Vazio")
		grade_de_itens.append(linha)

# 🛠️ FUNÇÃO ESSENCIAL: Procura a primeira casinha vazia disponível e joga o item lá!
func adicionar_item_na_marra(nome_do_item: String) -> bool:
	for l in range(4):
		for c in range(7):
			if grade_de_itens[l][c] == "Vazio":
				grade_de_itens[l][c] = nome_do_item
				return true # Item adicionado com sucesso!
	print("Inventário cheio!")
	return false # Não tinha espaço
