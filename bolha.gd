extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var bolha: Node2D = $"."
@onready var cenario: Node2D = $".."

var direction: bool = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction == true:
		position.x += 1* delta  # Movimento horizontal
	else:
		position.x += -1* delta  # Movimento horizontal
	position.y += -10 * delta  # Movimento vertical
	if cenario.agua == false:
		queue_free()

func _on_timer_timeout() -> void: #Para simbolizar o movimento
	if direction == false:
		direction = true
	else:
		direction = false

func _on_timer_2_timeout() -> void: #Tempo máximo da bolha
	sprite.play("Pegou")
	Som.playAudio("BolhaEstoura")
	await sprite.animation_finished
	queue_free() # Destrói a bolha se tempo limite é chegado

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.respiracao > 0: # Se o corpo for do tipo do jogador
		sprite.play("Pegou")
		body.aumentarRespiração(300)  # Aumenta a respiração	
		Som.playAudio("BolhaEstoura")
		await sprite.animation_finished
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_node("..").name == "BolhaGigante":
		_on_timer_2_timeout()
