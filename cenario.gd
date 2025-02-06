extends CanvasLayer

@onready var player: CharacterBody2D = $"Player"
@onready var aguaSprite: AnimatedSprite2D = $"Fundo/Agua"
@onready var barragem: AnimatedSprite2D = $Barragem
@onready var alcance: RayCast2D = $Alcance
@onready var bolha = preload("res://bolha.tscn")
@onready var flecha = preload("res://flecha.tscn")
@onready var bomba = preload("res://bomba.tscn")
@onready var bolhaGigante = preload("res://bolha_gigante.tscn")
@onready var som: Node2D = $"../Som"
var rng = RandomNumberGenerator.new()

var bombaCenario: bool = false
var bolhaGiganteCenario: bool = false
var agua: bool = 1 #Se a água está presente ou não
var torreVida: int = 10000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	verificaBarragem()
	if agua == false:
		aguaSprite.position.y += 1
		
	if player.position.x < -25:
		Global.flagRotaF = true
		if !agua:
			Global.flagRotaG = true
		
func verificaBarragem():
	if alcance.is_colliding():
		verificaDano()
		
	if torreVida >= 8000:
		barragem.play("Q1")
	elif torreVida >= 5000:
		barragem.play("Q2")
		player.flagSound = true
		Global.flagSound = true
	elif torreVida >= 0:
		barragem.play("Q3")
	else:
		barragem.play("Q4")
		if get_node("StaticBody2D") != null:
			get_node("StaticBody2D").queue_free()
		agua = 0
		Global.score = 0
		
		if player.position.x > 200:
			if player.flagBulletProof:
				if Global.dificuldade == "Hard":
					Global.gloriousEvolution = true
				Global.flagRotaC = true
			else:		
				if !player.flagArrow:
					Global.flagGlouriousClicker = true ##Significa que passou sem usar poderes
				Global.flagRotaA = true
		
func verificaDano():
	if player.sprite.animation == "Hit":
		torreVida -= 1 #Normalmente é 1
	print(torreVida)

func criaObjeto():
	if player.flagBubble == true:
		if bolhaGiganteCenario == false:
			bolhaGiganteCenario = true
			var novaBolha = bolhaGigante.instantiate()  # Instancia a flecha
			add_child(novaBolha)  # Adiciona a bolha ao cenário
	elif player.flagBomb == true:
		if bombaCenario == false:
			bombaCenario = true
			var novaBomba = bomba.instantiate()  # Instancia a flecha
			add_child(novaBomba)  # Adiciona a bolha ao cenário
	elif player.flagArrow == true:
		var novaFlecha = flecha.instantiate()  # Instancia a flecha
		add_child(novaFlecha)  # Adiciona a bolha ao cenário

func _on_timer_timeout() -> void:
	if agua == true:
		var novaBolha = bolha.instantiate()
		add_child(novaBolha)  # Adiciona a bolha ao cenário
		# Define uma posição aleatória no chão ou na parede
		var posicao_x = rng.randf_range(0, 200)  # Exemplo de posição X aleatória
		var posicao_y = 170  # Exemplo de posição Y aleatória
		novaBolha.position = Vector2(posicao_x, posicao_y)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_node("..").name == "Bomba":
		await get_tree().create_timer(1.5).timeout 
		torreVida -= 5000
	else:
		torreVida -= 20
		area.get_node("..").queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
