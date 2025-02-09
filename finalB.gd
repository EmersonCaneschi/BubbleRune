extends Node2D
@onready var mensagem: Label = $Mensagem
@onready var player: Sprite2D = $Player
@onready var bolha: Node2D = $Bolha

var directionBolha: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finalB()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Volta") or Input.is_action_just_pressed("Hit")) and !get_tree.is_null():
		get_tree().change_scene_to_file("res://menu.tscn")
	
	if directionBolha == true:
		bolha.position.y += 3* delta  # Movimento horizontal
	else:
		bolha.position.y += -12* delta  # Movimento horizontal
	bolha.position.x += 6 * delta  # Movimento vertical
	
	
		
func finalB() -> void:
	mensagem.position = Vector2( 0 , 30)
	Som.playAudio("Final")
	await get_tree().create_timer(2).timeout
	mensagem.show()
	mensagem.set_text("Flutando como bolhas...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Um maquinário cognato...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Com engragens de um fogo roubado...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Nova possibilidade cacofônica...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Para acender a forja...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Da esperança.")
	await get_tree().create_timer(3.25).timeout
	mensagem.position = Vector2(0, 80)
	mensagem.add_theme_color_override("font_color", Color(128, 0, 0, 1)) 
	mensagem.set_text("Final B:\n [B]olhificado")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_timer_timeout() -> void:
	if directionBolha == false:
		directionBolha = true
	else:
		directionBolha = false
