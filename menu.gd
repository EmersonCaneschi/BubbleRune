extends Node2D
@onready var hBox: HBoxContainer = $HBoxContainer
@onready var bubblemans: TextureRect = $CanvasLayer/TextureRect/TextureRect2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.conquistas()
	get_node("CanvasLayer/Score").set_text("Melhor pontuação: " + str(Global.highScore))
	get_node("CanvasLayer/Percentage").set_text(str(Global.completionist) + "%")
	if Global.flagRotaA:
		bubblemans.show()
		get_node("CanvasLayer/HBoxContainer").position = Vector2(50, 70)
		get_node("CanvasLayer/Label").position = Vector2(55,35)
	else:
		get_node("CanvasLayer/HBoxContainer").position = Vector2(133, 125)
		get_node("CanvasLayer/Label").position = Vector2(75, 70)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Volta"):
		get_tree().quit()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://cenaAbertura.tscn")

func _on_about_pressed() -> void:
	get_tree().change_scene_to_file("res://sobre.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
