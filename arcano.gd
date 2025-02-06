extends Node
@onready var player: CharacterBody2D = $".."
@onready var mindinho: TextureRect = $"../../../Maos/Mao Fechada/Mindinho"
@onready var anelar: TextureRect = $"../../../Maos/Mao Fechada/Anelar"
@onready var medio: TextureRect = $"../../../Maos/Mao Fechada/Médio"
@onready var indicador: TextureRect = $"../../../Maos/Mao Fechada/Indicador"
@onready var polegar: TextureRect = $"../../../Maos/Mao Fechada/Polegar"
@onready var runas: AnimatedSprite2D = $Runas
@onready var branco: AudioStreamPlayer2D = $Branco
@onready var preto: AudioStreamPlayer2D = $Preto
@onready var poderes: AnimatedSprite2D = $"../../../Maos/Poderes"
@onready var contaSino: Timer = $ContaSino
@onready var som: Node2D = $"../../../Som"
@onready var mensagem: Label = $Mensagem

var arrow: Array = [2, 3, 2, 4, 3, 1, 2, 3, 2, 5]  # Senha desejada
var bomb: Array = [2, 2, 1, 2, 2, 3, 2, 4, 2, 2, 2, 3, 2, 4, 2, 3, 2, 4] 
var bubble: Array = [3, 2, 5, 4, 5, 2, 4, 3] 
var bulletProof: Array = [3, 2, 4, 4, 1, 5, 1, 1, 2, 3, 2, 5, 4, 4]
var teclasPressionadas: Array = []  # Teclas pressionadas pelo jogador
var teclaRuna: Array = [] 
@onready var contador: Timer = $Contator
var musica: bool = false
var sinoToca: bool = false #Menor para verificar cada siclo
var silencio: bool = true #Maior para verificar num geral


var runasSimbolos: Dictionary = {
	11: [1, 1],
	12: [1, 2],
	15: [1, 5],
	21: [2, 1], 
	22: [2, 2], 
	23: [2, 3],
	24: [2, 4],
	25: [2, 5],
	31: [3, 1],
	32:[3, 2],
	43:[4, 3],
	44:[4, 4],
	52:[5, 2],
	53:[5, 3],
	54:[5, 4]
}

#var dedos: Dictionary = {
#	1: ["mindinho"],
#	2: ["anelar"],
#	3: ["medio"], 
#	4: ["indicador"], 
#	5: ["polegar"],
#}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	runas.position = player.position + Vector2(10, 80)
	verificaDedo()
	#if player.flagSound: #Precisa criar uma forma de modulaarizar verificaDedo para não colocar no append se flagSound = false, usar dicionário? Identar os debaixo aqui
	verificaSenha()
	runaAparece()

func verificaDedo() -> void:
	if Input.is_action_just_pressed("1"):
		teclaRuna.append(1)
		mindinho.show()
	if Input.is_action_just_released("1"):
		mindinho.hide()
	if Input.is_action_just_pressed("2"):
		teclaRuna.append(2)
		anelar.show()
	if Input.is_action_just_released("2"):
		anelar.hide()
	if Input.is_action_just_pressed("3"):
		teclaRuna.append(3)
		medio.show()
	if Input.is_action_just_released("3"):
		medio.hide()
	if Input.is_action_just_pressed("4"):
		teclaRuna.append(4)
		indicador.show()
	if Input.is_action_just_released("4"):
		indicador.hide()
	if Input.is_action_just_pressed("5"):
		teclaRuna.append(5)
		polegar.show()
	if Input.is_action_just_released("5"):
		polegar.hide()
	
func verificaSenha() -> void:		
	var senhaAtual
	if player.flagArrow == false:
		senhaAtual = arrow
	elif player.flagBomb == false:
		senhaAtual = bomb
	elif player.flagBubble == false:
		senhaAtual = bubble
	elif player.flagBulletProof == false:
		senhaAtual = bulletProof
	else:
		senhaAtual.clear()
		
	if teclasPressionadas == senhaAtual and !senhaAtual.is_empty():
		som.lista(1)
		if senhaAtual == arrow:
			poderes.play("Flecha")
			player.flagArrow = true
		elif senhaAtual == bomb:
			poderes.play("Bomba")
			player.flagBomb = true
			silencio = 1
		elif senhaAtual == bubble:
			poderes.play("Bolha")
			player.flagBubble = true
			silencio = 1
		elif senhaAtual == bulletProof:
			silencio = 1
			player.flagBulletProof = true
			player.flagBomb = false
			player.flagBubble = false
			poderes.hide()
	
	if !senhaAtual.is_empty() and silencio and player.flagSound:
		runeSound(senhaAtual)
		
func runaAparece():
	if teclaRuna.size() == 2:
		teclasPressionadas.append(teclaRuna[0])
		teclasPressionadas.append(teclaRuna[1])
		var chave = str(teclaRuna[0]) + str(teclaRuna[1])
		if int(chave) in runasSimbolos:
			contador.start()
			teclas(str(chave))
		else:
			contador.start()
			contador.wait_time = 0.01

func teclas(num: String) -> void:
	contador.wait_time = 3
	runas.show()
	runas.play("Surge")
	teclaRuna.clear()
	await runas.animation_finished
	runas.play(num)
	
func _on_contator_timeout() -> void:
	runas.play("Some")
	await runas.animation_finished
	teclasPressionadas.clear()
	runas.hide()
	teclaRuna.clear()
	contador.wait_time = 3
	contador.stop()
		
func runeSound(senha: Array):
	silencio = false
	help(senha)
	var padrao = senha.duplicate()
	var i: int = 0
	while i < padrao.size():
		if silencio:
			break
		while padrao[i] > 0:
			if silencio:
				break
			if !sinoToca:
				if i % 2 == 0:
					branco.play()
				else:
					preto.play()
				sinoToca = true
				contaSino.start()  # Timer para controlar o tempo entre toques
				padrao[i] -= 1
			await get_tree().create_timer(0.1).timeout  # Pequena pausa para verificar novamente
		i += 1
	await get_tree().create_timer(1.5).timeout
	som.lista(1)
	await get_tree().create_timer(10).timeout
	silencio = true

func _on_conta_sino_timeout() -> void:
	sinoToca = false
	
func help(senha: Array) -> void:
	mensagem.position = Vector2(20, 25)
	mensagem.show()
	if player.flagArrow:
		mensagem.set_text("Uma nova possibilidade")
	else:
		mensagem.set_text("Eu. Ouço. Um. Som.")
	await get_tree().create_timer(3).timeout
	mensagem.hide()
