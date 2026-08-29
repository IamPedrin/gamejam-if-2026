extends Node2D
@onready var player = $PlayerTd/Player


func _ready() -> void:
	# Faz a casa escutar o relógio e te fazer dormir se der meia noite
	SistemaTempo.meia_noite.connect(_desmaiar_na_casa)

func _desmaiar_na_casa() -> void:
	# Passa o dia automaticamente e verifica as regras
	Global.dormir_e_processar_dia(get_tree())
