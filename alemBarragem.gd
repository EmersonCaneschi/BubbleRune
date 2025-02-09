extends Node2D
@onready var mensagem: Label = $Mensagem
@onready var player: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var bubbleMan: CharacterBody2D = $Bubbleman
@onready var bubbleManLoad = preload("res://bubbleman.tscn")
@onready var bubbleManSpawn: Timer = $Timer
@onready var fadeOut: TextureRect = $FadeOut

var rng = RandomNumberGenerator.new()

var cena: bool = true
var timerSpawn: bool = false
var trocaTela: bool = true
var aviso: bool = false
#O script no geral tem pontos em comum com outros, porém apresenta uuma versão demasiadamente simplificada, o que determina a falta de necessidade de muitas coisas

func _ready() -> void:
	get_node("Fundo/Agua").hide()
	get_node("Fundo/Background2").hide()
	inicio()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Volta") and !get_tree.is_null():
		get_tree().change_scene_to_file("res://menu.tscn")
	if cena and player != null:
		if player.animation == "Walk":
			get_node("Fundo/Background5").position.x -= 0.034
			get_node("Fundo/Background4").position.x -= 0.034
			get_node("Fundo/Sprite2D").position.x -= 0.034
			if get_node("Bubbleman") != null:
				get_node("Bubbleman").position.x -= 0.032
			get_node("Player").position.x += 0.019
		
	if bubbleMan == null and !aviso:
		cena = true
		mensagem.show()
		player.play("Walk")
		player.get_node("..").position.x += 0.06
		mensagem.add_theme_color_override("font_color", Color(128, 0, 0, 1))
		mensagem.set_text("Eles não irão descansar até ter uma conclusão.")
		await get_tree().create_timer(3).timeout
		mensagem.set_text("Encare o seus medos de frente e sobreviva.")
		await get_tree().create_timer(3).timeout
		mensagem.hide()
		player.play("Idle")
		aviso = true
		cena = false
		timerSpawn = true
		print("Timer Spawn: ")
		print(timerSpawn)
		
#fazer uma cena = 1 nisso
	if !cena and timerSpawn and player.get_node("..") != null: #Segunda Parte
		print("3 - Spawner contador")
		timerSpawn = false
		bubbleManSpawn.start()
		
	if fadeOut.visible and fadeOut.self_modulate.a < 255 and Global.flagRotaH:
		fadeOut.self_modulate.a += 0.0004

func geraInimigo() -> void:
	print("5 - Era para gerar inimigo")
	var novoBubbleman = bubbleManLoad.instantiate()  # Instancia a flecha
	add_child(novoBubbleman)  # Adiciona a bolha ao cenário
	var posicao = rng.randi_range(0, 1)
	var posicao2 = rng.randi_range(300, 350)
	#novoBubbleman.position = Vector2( posicao*posicao2 + (posicao2 - 280)*(posicao-1),130)
	novoBubbleman.position = Vector2( 300 * posicao - 33,130)
	novoBubbleman.get_node("AnimatedSprite2D").play("Atirar")
	print("6 - Fim gerar inimigo")
		
func inicio() -> void:
	mensagem.position = Vector2(0 , 30)
	await get_tree().create_timer(2).timeout
	mensagem.show()
	mensagem.set_text("Finalmente consegui sair...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Eu nem acredito que deu tudo certo no final...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Mas... O que é isso?")
	player.play("Idle")
	await get_tree().create_timer(3).timeout
	mensagem.add_theme_color_override("font_color", Color(0.6627, 1.0, 1.0, 1.0) ) 
	mensagem.position = Vector2(0 , 130)
	mensagem.set_text("Todos os estouradores de bolhas\nvão levar bolhas dos fortões até estourar.")
	Som.playAudio("Fogo!")
	await get_tree().create_timer(4).timeout
	Global.sobreviveu = 0
	bubbleMan.get_node("AnimatedSprite2D").play("Atirar")
	cena = false
	mensagem.hide()

func finalA():
	mensagem.add_theme_color_override("font_color", Color(255, 0, 0, 0) )
	mensagem.show()
	mensagem.set_text('"Não há disparo que dele saia uma flor"')
	player.play("Morreu")
	await player.animation_finished
	player.queue_free()
	if bubbleMan != null: 
		bubbleMan.get_node("AnimatedSprite2D").play("Idle")
	await get_tree().create_timer(2).timeout
	mensagem.set_text('"Não há uma arma que dela saia amor"')
	await get_tree().create_timer(4).timeout
	mensagem.set_text('"Não há uma arma que dela não saia maldade"')
	await get_tree().create_timer(4).timeout
	mensagem.set_text('"Não há maldade que dela saia paz"')
	await get_tree().create_timer(4).timeout
	Som.playAudio("FinalRuim")
	mensagem.position = Vector2(0, 80)
	mensagem.add_theme_color_override("font_color", Color(128, 0, 0, 1)) 
	mensagem.set_text("Final A:\n[A]nátema")
	await get_tree().create_timer(5).timeout
	if trocaTela:
		trocaTela = false
		get_tree().change_scene_to_file("res://menu.tscn")

func finalC():
	cena = true
	mensagem.position = Vector2(0 , 30)
	mensagem.show()
	fadeOut.show()
	mensagem.add_theme_color_override("font_color", Color(255, 0, 0, 0) )
	mensagem.set_text("Um padrão e adaptação...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("O potencial do humano...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Não é limitado, mas é guiado...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Mas sempre que aprende...")
	await get_tree().create_timer(4).timeout
	Som.playAudio("Final")
	mensagem.set_text("Ele muta...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Até quando somos humanos?")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("A Gloriosa evolução...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Foi alcançada?")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Escolha o que você fará com isso.")
	await get_tree().create_timer(4).timeout
	mensagem.position = Vector2(0, 80)
	mensagem.add_theme_color_override("font_color", Color(128, 0, 0, 1)) 
	mensagem.set_text("Final C:\n[C]ondenação")
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://menu.tscn")

func finalH():
	cena = true
	mensagem.position = Vector2(0 , 30)
	mensagem.show()
	fadeOut.show()
	mensagem.set_text("Você...")
	await get_tree().create_timer(2).timeout
	mensagem.set_text("Não é um humano...")
	await get_tree().create_timer(2).timeout
	mensagem.add_theme_color_override("font_color", Color(255, 0, 0, 0) )
	mensagem.position = Vector2(0 , 30)
	mensagem.set_text("Não temam...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Vocês não tinham outra escolha.")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Mas eu cheguei.")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Devamos esperar um pouco...")
	await get_tree().create_timer(4).timeout
	mensagem.set_text("Até que eles não estejam mais aqui.")
	await get_tree().create_timer(4).timeout
	Som.playAudio("FinalRuim")
	mensagem.position = Vector2(0, 80)
	mensagem.add_theme_color_override("font_color", Color(128, 0, 0, 1)) 
	mensagem.set_text("Final H:\n[H]omem")
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_timer_timeout() -> void:
	print("4 - Spawner acabou, gera inimigo")
	geraInimigo()
	timerSpawn = true
	bubbleManSpawn.wait_time = 5
