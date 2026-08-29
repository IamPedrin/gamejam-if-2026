extends CanvasLayer

var itens_hotbar: Array[String] = [
	"Enxada", "Regador", "Semente_1", "Semente_2", "Fertilizante", "", "", "", ""
]

var slot_selecionado: int = 0 

@onready var container_slots = $HBoxContainer
@onready var seletor = $SeletorVisual

func _ready() -> void:
	seletor.size = Vector2(40, 40)
	selecionar_slot(0)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode >= KEY_1 and event.keycode <= KEY_9:
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
