extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var flecha = preload("res://flecha.tscn")

const SPEED = 100.0

func _physics_process(delta: float) -> void:
	if !get_node("..").cena:
		var direction := Input.get_axis("Left", "Right")
		if direction > 0:
			sprite.flip_h = false
		elif direction < 0:
			sprite.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Hit") and Global.flagBulletProof and !get_node("..").cena and get_node("../Bubbleman") != null:
		var novaFlecha = flecha.instantiate()  # Instancia a flecha
		get_node("..").add_child(novaFlecha)  
