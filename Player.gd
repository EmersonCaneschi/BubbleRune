extends CharacterBody2D

var respiracao: int = 5000
@onready var cenario: CanvasLayer = $".."
@onready var barra: ProgressBar = $"../../Barra/TextureRect/Respiração"
@onready var sprite: AnimatedSprite2D = $AnimatedPlayer
@onready var player: CharacterBody2D = $"."
@onready var arcano: Node = $Arcano

var flagSound: bool = false
var flagArrow: bool = false
var flagBomb: bool = false
var flagBubble: bool = false
var flagBulletProof: bool = false
var bolhasPegas: int = 0

const SPEED = 100.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("Left", "Right")
	if direction and respiracao > 0:
		velocity.x = direction * SPEED
		if direction > 0:
			sprite.flip_h = false
		elif direction < 0:
			sprite.flip_h = true
		sprite.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	await sprite.animation_finished
	sprite.play("Idle")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	barra.max_value = respiracao

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cenario.agua == true:
		respiracao += - 1
		Global.score += 1
	atualizaBarra()
	if Input.is_action_just_pressed("Hit"):
		if sprite.animation == "Idle" || flagArrow :  #Não pode bater enquanto estiver se mexendo
			verificaFlags()
	
func atualizaBarra():
	barra.value = respiracao
	if respiracao <= 0:
		morreu()

func verificaFlags():
	if flagArrow == true:
		cenario.criaObjeto()
	else:
		sprite.play("Hit")
		await sprite.animation_finished
		
func morreu():
	sprite.play("Morreu")
	if Global.score > Global.highScore:
		Global.highScore = Global.score
	await sprite.animation_finished
	get_node("../..").fimJogo()   #Troca de cena para voltar ao menu

# Método para aumentar a respiração do jogador
func aumentar_respiração(valor: int) -> void:
	bolhasPegas += 1
	respiracao += (valor - bolhasPegas)
	barra.value = respiracao  # Atualiza a barra de respiração
	if respiracao > barra.max_value:  # Se a respiração ultrapassar o limite, ajusta para o máximo
		respiracao = barra.max_value
