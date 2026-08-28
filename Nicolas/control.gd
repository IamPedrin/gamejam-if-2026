extends Control

# Pega a referência automática dos slots dentro do seu GridContainer
@onready var grid_container: GridContainer = $GridContainer

# Carrega o ícone padrão do Godot para usarmos de teste visual
var icone_teste: Texture2D = preload("res://icon.svg")

func _ready() -> void:
	print("--- MODO DE TESTE ISOLADO ATIVADO ---")
	print("Pressione 'P' no teclado para simular: Coletar 1 Poção")
	print("Pressione 'O' no teclado para simular: Coletar 5 Poções")
	print("Pressione 'M' no teclado para simular: Coletar 1 Moeda")

# O Godot vai ler o teclado diretamente por aqui para testarmos sem personagem
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_P:
			coletar_item("pocao", icone_teste, 1)
		elif event.keycode == KEY_O:
			coletar_item("pocao", icone_teste, 5)
		elif event.keycode == KEY_M:
			coletar_item("moeda", icone_teste, 1)

# A FUNÇÃO PRINCIPAL: Adiciona o item ou soma a quantidade
func coletar_item(novo_id: String, icone_item: Texture2D, qtd_coletada: int) -> void:
	
	# PASSO 1: Percorre os painéis que você já tem na tela para ver se o item já existe lá
	for slot in grid_container.get_children():
		# Verifica se o slot já tem esse ID guardado na memória dele
		if slot.has_meta("item_id") and slot.get_meta("item_id") == novo_id:
			var qtd_atual: int = slot.get_meta("quantidade")
			var nova_qtd: int = qtd_atual + qtd_coletada
			
			# Atualiza a memória interna do slot
			slot.set_meta("quantidade", nova_qtd)
			
			# Atualiza o texto na tela
			var label_qtd = slot.get_node("Label") as Label
			label_qtd.text = str(nova_qtd)
			
			print("Item duplicado encontrado! Somado +" + str(qtd_coletada) + ". Total no slot: " + str(nova_qtd))
			return # Finaliza a função porque já resolveu o problema

	# PASSO 2: Se não achou item igual, procura pelo primeiro slot totalmente disponível
	for slot in grid_container.get_children():
		if not slot.has_meta("item_id"):
			# Registra o ID e a quantidade na memória interna desse slot vazio
			slot.set_meta("item_id", novo_id)
			slot.set_meta("quantidade", qtd_coletada)
			
			# Pega os nós visuais filhos que você criou (TextureRect e Label)
			var texture_rect = slot.get_node("TextureRect") as TextureRect
			var label_qtd = slot.get_node("Label") as Label
			
			# Aplica a imagem e a quantidade inicial no slot da interface
			texture_rect.texture = icone_item
			label_qtd.text = str(qtd_coletada)
			
			print("Novo item '" + novo_id + "' adicionado em um slot vazio com quantidade: " + str(qtd_coletada))
			return # Finaliza a função

	# Se o código passar pelos dois loops e chegar aqui, significa que acabou o espaço
	print("Não foi possível adicionar: Todos os slots visuais estão cheios!")
