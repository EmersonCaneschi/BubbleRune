extends CharacterBody2D

@onready var tiro = preload("res://disparo.tscn")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var atirou: bool = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if sprite.animation == "Atirar" and !atirou and Global.sobreviveu <= 25:
		atirou = true
		var novoTiro = tiro.instantiate()  # Instancia a flecha
		add_child(novoTiro)  # Adiciona a bolha ao cenário
		Som.playAudio("Tiro")
	if position.x < 0:
		sprite.flip_h = false
	
	if Global.sobreviveu == -1:
		sprite.play("Idle")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_node("..").name == "Flecha":
		queue_free()
