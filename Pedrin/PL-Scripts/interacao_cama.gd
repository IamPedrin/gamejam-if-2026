extends Interactable

func interagir() -> void:
	print("Você foi dormir mais cedo...")
	
	Global.item_equipado = ""
	
	Global.dormir_e_processar_dia(get_tree())
