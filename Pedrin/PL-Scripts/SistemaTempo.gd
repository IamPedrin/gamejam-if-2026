extends Node

signal tempo_atualizado(hora: int, minuto: int)
signal meia_noite
signal dia_mudou(dia: int, estacao: String) # Novo sinal para atualizar a HUD

const MINUTOS_TOTAIS_DIA = 17.0 * 60.0 
const SEGUNDOS_REAIS = 30.0 

var tempo_passado: float = 0.0
var relogio_rodando: bool = true
var fracao_dia: float = 0.0

# Novas variáveis do Calendário
var dia_atual: int = 1
var estacoes: Array[String] = ["Verão", "Outono", "Inverno", "Primaveira"]

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

func obter_estacao_atual() -> String:
	var indice = ((dia_atual - 1) / 3) % 4
	return estacoes[indice]

# Substitua a sua função resetar_dia antiga por esta:
func avancar_dia() -> void:
	dia_atual += 1
	
	if dia_atual > 12:
		print("Fim do Jogo! Você sobreviveu um ano inteiro.")
		
	tempo_passado = 0.0
	relogio_rodando = true
	
	# Emite o sinal avisando a HUD que o dia e a estação mudaram
	dia_mudou.emit(dia_atual, obter_estacao_atual())
