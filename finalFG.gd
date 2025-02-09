extends Node2D
@onready var mensagem: Label = $Mensagem
@onready var sprite: AnimatedSprite2D = $Fundo/AnimatedPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mensagem.position = Vector2( 0 , 30)
	if Global.flagRotaG:
		get_node("Fundo/Agua").hide()
		get_node("Fundo/Background2").hide()
		finalG()
	else:
		finalF()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Volta") or Input.is_action_just_pressed("Hit")) and !get_tree.is_null():
		get_tree().change_scene_to_file("res://menu.tscn")
	
	if sprite.animation == "Walk":
		sprite.position.x -= 0.51
	if sprite.position.x < -13:
		sprite.position.x = 253

func finalF() -> void:
	await get_tree().create_timer(2.5).timeout
	mensagem.show()
	mensagem.set_text("Plinio Rocambole nadou e nadou...")
	await get_tree().create_timer(5).timeout
	mensagem.set_text("Onde ele pode ele chegou...")
	await get_tree().create_timer(5).timeout
	mensagem.set_text("Porém não era o bastante...")
	await get_tree().create_timer(5).timeout
	sprite.play("Idle")
	mensagem.set_text("Ele esperou que alguém o buscasse...")
	await get_tree().create_timer(5).timeout
	mensagem.set_text("Mas ninguém veio.")
	await get_tree().create_timer(3).timeout
	Som.playAudio("FinalRuim")
	sprite.play("Morreu")
	await sprite.animation_finished
	sprite.hide()
	mensagem.position = Vector2(0, 80)
	mensagem.add_theme_color_override("font_color", Color(128, 0, 0, 1)) 
	mensagem.set_text("Final F:\n [F]racassado")
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://menu.tscn")
	
func finalG() -> void:
	Som.playAudio("Final")
	await get_tree().create_timer(2.6).timeout
	mensagem.show()
	mensagem.set_text("Plinio Rocambole andou e andou...")
	await get_tree().create_timer(5).timeout
	mensagem.set_text("A barragem era enorme...")
	await get_tree().create_timer(5).timeout
	mensagem.set_text("Mas sentia que era 'O certo a se fazer'...")
	sprite.hide()
	await get_tree().create_timer(5).timeout
	mensagem.position = Vector2(0, 80)
	mensagem.add_theme_color_override("font_color", Color(128, 0, 0, 1)) 
	mensagem.set_text("Final G:\n [G]enial")
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://menu.tscn")
