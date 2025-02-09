extends Node

var ciclo: int = 0
var flagSobre: bool = 0
var flagSound: bool = 0
var flagBomba: bool = 0
var flagBulletProof: bool = 1
var flagRotaA: bool = 0
var flagRotaB: bool = 0
var flagRotaC: bool = 0
var flagRotaF: bool = 0
var flagRotaG: bool = 0
var flagRotaH: bool = 0
var sobreviveu: int = 0
var glouriousClicker: bool = 0
var highScore: int = 0
var score: int = 0
var completionist: int = 0

func conquistas():
	var pontua = (highScore/1000)
	if pontua >= 10:
		pontua = 5
		
	completionist = int(pontua) + 3*int(flagSobre) + 5*int(flagSound) +10*int(flagRotaA) + 10*int(flagRotaB) + 15*int(flagRotaC) + 8*int(flagRotaF) + 9*int(flagRotaG) + 15*int(flagRotaH) + 20*int(glouriousClicker)
