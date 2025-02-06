extends Node2D

@onready var player: CharacterBody2D = $"../Player"
var direction: bool = 0
var entrou:bool =false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(100, 100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction == true:
		position.x += 3* delta  # Movimento horizontal
	else:
		position.x += -3* delta  # Movimento horizontal
	position.y += -10 * delta  # Movimento vertical
	
	if entrou:
		player.position = position - Vector2(10,120)
		player.respiracao = 3000
	
	if position.y < -35:
		get_node("..").bolhaGiganteCenario = false
		if entrou:
			Global.flagRotaB = true
		else: 
			queue_free()
			
func _on_timer_timeout() -> void:
	if direction == false:
		direction = true
	else:
		direction = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	#entrandoBolha()
	entrou = true #Coloca personagem dentro da bolha

func entrandoBolha():
	if player.position != position - Vector2(10,120):
		if player.position.x < position.x - 10:
			player.position.x += 1
		elif player.position.x > position.x - 10:
			player.position.x -= 1
		if player.position.y < position.y - 120:
			player.position.y += 1
		elif player.position.y > position.y - 120:
			player.position.y -= 1
		entrandoBolha()
