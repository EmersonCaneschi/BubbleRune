extends Node2D
@onready var player: CharacterBody2D = $"../Player"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = player.position + Vector2(0, 80 + player.position.x/9)
	if player.position.x < 3:
		rotation = 0.2
	else:
		rotation = 1/player.position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += 150* delta
	position.y += 25*delta
