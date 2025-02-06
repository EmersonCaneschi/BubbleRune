extends Node2D
@onready var aviao: AnimatedSprite2D = $Fundo/Aviao
@onready var mensagem: Label = $Mensagem
@onready var plinio: Sprite2D = $Plinio

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texto()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Volta") or Input.is_action_just_pressed("Hit")) and !get_tree.is_null():
		get_tree().change_scene_to_file("res://jogo.tscn")
	
	aviao.position.x += 0.15
	if aviao.animation == "aberto":
		if plinio.position.x < 0:
			plinio.position = aviao.position + Vector2(-7,3)
		plinio.position += Vector2(-0.025, 0.1)

func texto() -> void:
	await get_tree().create_timer(1).timeout
	mensagem.show()
	mensagem.set_text("Plinio Rocambole é um contrabandista que vive uma vida fácil\nMas hoje durante uma de suas viagens ilegais...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Ao passar por cima do triângulo das bermudas, o avião de plínio\napresentou uma falha crítica...")
	await get_tree().create_timer(2).timeout
	aviao.play("aberto")
	await get_tree().create_timer(2).timeout
	mensagem.hide()
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://jogo.tscn")
