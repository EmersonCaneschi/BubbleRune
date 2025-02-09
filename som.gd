extends Node

var audioPlayer : AudioStreamPlayer = AudioStreamPlayer.new()
var flagMente: bool = 0
var flagMorreu: bool = 0
var flagRunas: bool = 0

var audio: Dictionary = {
	"Sinos": preload("res://Assets/Remake/I Heard a Sound.mp3"),
	"Branco": preload("res://Assets/Remake/Som Branco.mp3"),
	"Preto": preload("res://Assets/Remake/Som Preto.mp3"),
	"Tiro": preload("res://Assets/Remake/Tiro.mp3"),
	"Blindado": preload("res://Assets/Remake/TiroFalha.mp3"),
	"Explosão": preload("res://Assets/Remake/Explosao.mp3"),
	"BolhaEstoura": preload("res://Assets/Remake/BolhaEstoura.mp3"),
	"Fogo!": preload("res://Assets/Remake/Atirar.wav"),
	"Flecha": preload("res://Assets/Remake/Flecha.wav"),
	"Final": preload("res://Assets/Remake/Final.mp3"),
	"FinalRuim": preload("res://Assets/Remake/FinalRuim.mp3"),
	"Runas": preload("res://Assets/Remake/Runas.mp3"),
	"Mente": preload("res://Assets/Remake/MenteSofreu.mp3"),
	"Morreu": preload("res://Assets/Remake/Erro.mp3")
}
	
func playAudio(nome: String) -> void:
	if nome in audio:
		var audioPlayer = AudioStreamPlayer.new()
		audioPlayer.stream = audio[nome]
		add_child(audioPlayer)
		audioPlayer.play()
		audioPlayer.connect("finished", audioPlayer.queue_free)
