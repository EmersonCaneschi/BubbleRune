extends Node2D
@onready var agua: AnimatedSprite2D = $"./Node2D/Fundo/Agua"
@onready var bolha: AnimatedSprite2D = $Node2D/bolha
@onready var info: Label = $"CanvasLayer/Info"

var infoNum: int = 0

var texto: Dictionary = {
	0: "Bubblerune é um jogo basseado\n em mecânicas de clicker e puzzle\n com diversos finais influenciados\n por ações e decisões do jogador.",
	1: "Como jogar:\n AD, Setas: Andar\nEspaço, Enter, Mouse: Bater ou Itens\nEsc: Sair\n1, 2, 3, 4, 5: Dedos",
	2: "Créditos:\nDiretor: \nEmerson Caneschi\n\nDesenvolvedor: \nEmerson Caneschi", 
	3: "Créditos:\nAssets Refeitos:\nMatheus Caneschi\n\nVoice Actor:\nEmmanuel Gomes", 
	4: "Créditos:\nApoio:\nAmauri Junior\nDayane Guimaraes\nJoão Pedro Salim\nPedro Franco\nValtencir Teixeira",
	5: "Créditos:\nPoema:\nPH Santos\n\nSound Effects:\nMysticus\nCavia\nSquare Enix",
	6: "All sound effects used in \nthis project are the property of Square Enix.\nThis is a non-commercial fan project intended\nfor educational and entertainment purposes.\nNo copyright infringement is intended."
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.flagSobre = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mostra()
	if Input.is_action_just_pressed("Right"):
		Som.playAudio("BolhaEstoura")
		if infoNum == 6:
			infoNum = 0
		else:
			infoNum += 1
	elif Input.is_action_just_pressed("Left"):	
		Som.playAudio("BolhaEstoura")
		if infoNum == 0:
			infoNum = 6
		else:
			infoNum -= 1
	if Input.is_action_just_pressed("Volta"):
		get_tree().change_scene_to_file("res://menu.tscn")

func mostra() -> void:
	info.set_text(str(texto[infoNum]))

func _on_quit_pressed() -> void:
	Som.playAudio("BolhaEstoura")
	get_tree().change_scene_to_file("res://menu.tscn")
