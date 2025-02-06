extends Node2D

#Finais A e C
#todos os garotos estouradores de bolhas vão levar surras dos fortões do bar até desmaiar.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Volta") or Input.is_action_just_pressed("Hit")) and !get_tree.is_null():
		get_tree().change_scene_to_file("res://menu.tscn")
		
	#if !get_tree.is_null():
	#	await get_tree().create_timer(2).timeout
	#	get_tree().change_scene_to_file("res://menu.tscn")
