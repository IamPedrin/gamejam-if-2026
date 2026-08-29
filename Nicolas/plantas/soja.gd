extends Area2D

# Configuração do tempo em segundos (3 minutos = 180 segundos)
# DICA: Mude para 3.0 apenas para testar rápido se ela está crescendo!
const TEMPO_MINUTOS: float = 180.0

func _ready():
	# Força achar o nó, não importa onde ele esteja na árvore
	var anim = find_child("AnimatedSprite2D", true, false)
	
	if anim:
		# Força a animação a ficar ativa e visível
		anim.visible = true
		
		# IMPORTANTE: Paramos o autoplay para controlar os frames na marra pelo tempo
		anim.stop() 
		anim.frame = 0 # Garante que começa como broto (Frame 0)
		
		# Criamos o cronômetro (Timer) via código
		var cronometro = Timer.new()
		cronometro.wait_time = TEMPO_MINUTOS
		cronometro.one_shot = false # Faz ele continuar contando após dar o tempo
		cronometro.autostart = true
		
		# Conecta o alarme do timer para chamar a nossa função abaixo
		cronometro.timeout.connect(func(): _passar_proximo_frame(anim))
		add_child(cronometro)
		
		print("--- CRONÔMETRO ATIVO: Mudando de frame a cada ", TEMPO_MINUTOS, " segundos ---")
	else:
		print("--- ERRO CRÍTICO: O NÓ ANIMATEDSPRITE2D SUMIU DA CENA! ---")

# Função que roda toda vez que se passam 3 minutos
func _passar_proximo_frame(anim: AnimatedSprite2D):
	if anim and anim.sprite_frames:
		var total_de_frames = anim.sprite_frames.get_frame_count("default")
		
		# Se ainda não chegou no último frame da planta (imagem 3), avança um frame
		if anim.frame < total_de_frames - 1:
			anim.frame += 1
			print("--- PLANTA CRESCEU: Indo para o frame ", anim.frame, " ---")
		else:
			print("--- AVISO: A planta já chegou no crescimento máximo! ---")
