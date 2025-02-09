extends Node2D

@onready var player: CharacterBody2D = $"../Player"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var rayCast: RayCast2D = $Area2D/RayCast2D

var alcance: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = player.position + Vector2(0, 123)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if alcance:
		player.respiracao = 0
 
func _on_timer_timeout() -> void:
	sprite.play("Explode")
	await get_tree().create_timer(0.25).timeout 
	if rayCast.is_colliding() and rayCast.get_collider() != null:
		if str(rayCast.get_collider().name) == "Player":
			alcance = true
	Som.playAudio("Explosão")
	await sprite.animation_finished
	get_node("..").bombaCenario = 0
	queue_free()
