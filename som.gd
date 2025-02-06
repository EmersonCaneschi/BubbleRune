extends Node2D

@onready var som: Node2D = $"."

var flagArcanoDesperta: bool = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func lista(numero: int):
	if numero == 1:
		som.get_node("./arcanoDesperta").play()
