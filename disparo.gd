extends Node2D
@onready var alemBarragem: Node2D = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(-22, -8)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_node("../AnimatedSprite2D").flip_h:
		position.x -= 80 *delta
	else: 
		position.x += 80  *delta
		
	if alemBarragem.cena:
		queue_free()
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.get_node("AnimatedSprite2D") != null and get_node(".").visible:
		get_node(".").hide()
		get_node("..").atirou = false
		if !Global.flagBulletProof || body.get_node("AnimatedSprite2D").flip_h == get_node("../AnimatedSprite2D").flip_h:
			alemBarragem.cena = true
			if !get_node("../../Mensagem").visible:
				Global.sobreviveu = -1
				alemBarragem.finalA()
		else: 		
			Som.playAudio("Blindado")
			Global.sobreviveu += 1
			if Global.sobreviveu > 10:
				if alemBarragem.bubbleMan != null:
					Global.flagRotaH = true
					await get_node("../AnimatedSprite2D").animation_looped
					get_node("../AnimatedSprite2D").play("Idle")
					alemBarragem.finalH()
				else:
					if Global.sobreviveu > 25:
						Global.flagRotaC = true
						alemBarragem.finalC()
