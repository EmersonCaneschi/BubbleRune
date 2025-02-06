extends Node

var ciclo: int = 0
var flagSobre: bool = 0
var flagSound: bool = 0
var flagRotaA: bool = 0
var flagRotaB: bool = 0
var flagRotaC: bool = 0
var flagRotaF: bool = 0
var flagRotaG: bool = 0
var dificuldade: String = "Hard"
var gloriousEvolution: bool = 0
var glouriousClicker: bool = 0
var trueEnd: int = 0
var highScore: int = 0
var score: int = 0
var completionist: int = 0

func conquistas():
	var pontua = (highScore/1000)
	if pontua >= 10:
		pontua = 5
		
	if trueEnd == 10:
		trueEnd = 1
	else: 
		trueEnd = 0
		
	completionist = int(pontua) + 4*int(flagSobre) + 4*int(flagSound) +9*int(flagRotaA) + 9*int(flagRotaB) + 13*int(flagRotaC) + 5*int(flagRotaF) + 5*int(flagRotaG) + 20*int(gloriousEvolution) + 25*trueEnd + 21*int(glouriousClicker)
#Rota D = 25, Rota E = 35, aumentar a todas as outras para dar 200%
#Rota G
#Flag trueEnd = quando vai para a rota c e mata os 10 inimigos
