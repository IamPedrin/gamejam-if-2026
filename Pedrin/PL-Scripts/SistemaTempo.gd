extends Node

signal tempo_atualizado(hora: int, minuto: int)
signal meia_noite

const MINUTOS_TOTAIS_DIA = 17.0 * 60.0 
const SEGUNDOS_REAIS = 180.0

var tempo_passado: float = 0.0
var relogio_rodando: bool = true
var fracao_dia: float = 0.0

func _process(delta: float) -> void:
	if not relogio_rodando: return
	
	tempo_passado += delta
	fracao_dia = clamp(tempo_passado / SEGUNDOS_REAIS, 0.0, 1.0)
	
	var minutos_in_game = int(fracao_dia * MINUTOS_TOTAIS_DIA)
	var hora = 7 + (minutos_in_game / 60)
	var minuto = minutos_in_game % 60
	
	tempo_atualizado.emit(hora, minuto)
	
	if hora >= 24:
		relogio_rodando = false
		meia_noite.emit()

func resetar_dia() -> void:
	tempo_passado = 0.0
	relogio_rodando = true
