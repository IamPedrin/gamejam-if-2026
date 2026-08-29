extends Interactable

var estado_terra: String = "normal"

@onready var sprite = $Sprite2D

func interagir() -> void:
	var item_na_mao = Global.item_equipado
	
	if item_na_mao == "Enxada" and estado_terra == "normal":
		estado_terra = "arado"
		sprite.modulate = Color("6b4226") 
		print("Você arou a terra!")
		
	elif item_na_mao == "Sementes" and estado_terra == "arado":
		estado_terra = "com_semente"
		sprite.modulate = Color("8fbc8f") 
		print("Sementes plantadas!")
		
	elif item_na_mao == "Regador" and (estado_terra == "com_semente" or estado_terra == "arado"):
		estado_terra = "molhado"
		sprite.modulate = Color("3d2314") 
		print("Terra molhada!")
		
	elif item_na_mao == "" and estado_terra == "pronto_para_colher":
		estado_terra = "normal"
		sprite.modulate = Color("ffffff") # Volta à cor original
		print("Você colheu o item!")
				
	else:
		print("Não aconteceu nada. (Item: ", item_na_mao, " | Estado: ", estado_terra, ")")
