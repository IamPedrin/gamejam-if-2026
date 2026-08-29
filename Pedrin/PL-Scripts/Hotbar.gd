extends CanvasLayer

var itens_hotbar: Array[String] = [
	"Enxada", "Regador", "Fertilizante", "Semente_1", "Semente_2"
]

var slot_selecionado: int = 0 

@onready var container_slots = $HBoxContainer
@onready var seletor = $SeletorVisual

func _ready() -> void:
	seletor.size = Vector2(40, 40)
	
	# Pausa de 1 frame para o HBoxContainer alinhar tudo antes de mover o seletor
	await get_tree().process_frame 
	
	_atualizar_icones() # Carrega as imagens do Database
	selecionar_slot(0)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode >= KEY_1 and event.keycode <= KEY_5:
			var indice = event.keycode - KEY_1
			selecionar_slot(indice)

func selecionar_slot(indice: int) -> void:
	slot_selecionado = indice
	
	var item_atual = itens_hotbar[indice]
	
	Global.item_equipado = item_atual 
	
	var slot_visual = container_slots.get_child(indice)
	seletor.global_position = slot_visual.global_position
	
	if item_atual != "":
		print("Equipado: ", item_atual)
	else:
		print("Mãos vazias")

func _atualizar_icones() -> void:
	for i in range(5):
		var nome_item = itens_hotbar[i]
		
		var slot_quadrado = container_slots.get_child(i)
		var icone_visual = slot_quadrado.get_node("TextureRect") as TextureRect
		
		if nome_item != "" and Database.itens.has(nome_item) and Database.itens[nome_item].has("textura"):
			icone_visual.texture = Database.itens[nome_item]["textura"]
		else:
			icone_visual.texture = null
