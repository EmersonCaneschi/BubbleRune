extends Node2D

var verificador: bool = false # Evita que seja chamada duas vezes para trocar cena
@onready var player: CharacterBody2D = $Cenario/Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Volta"):
		get_tree().change_scene_to_file("res://menu.tscn")
	if (Global.flagRotaA || Global.flagRotaC) and player.position.x > 240:
		get_tree().change_scene_to_file("res://alemBarragem.tscn")
	elif Global.flagRotaB and player.position.y < -30:
		get_tree().change_scene_to_file("res://finalB.tscn")
	elif (Global.flagRotaF || Global.flagRotaG) and player.position.x < -25:
		get_tree().change_scene_to_file("res://finalFG.tscn")

func fimJogo() -> void: #Perdi o Jogo
	if !verificador:
		verificador = true
		get_tree().change_scene_to_file("res://menu.tscn")
