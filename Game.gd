extends Node2D

signal onGameWin
signal onGameLoss

onready var timer = $GameTimer
onready var pizza = $Pizza
onready var eatText = $EatText
onready var background = $Background

func _ready():
	background.visible = false
	hideGameObjects()

func _process(delta):
	pass

func _on_GameTimer_onReadyOver():
	background.visible = true
	showGameObjects()
	
	pizza.acceptInput = true

func _on_GameTimer_onRanOutOfTime():
	if (pizza.hasBeenFullyEaten()):
		winGame()
	else:
		loseGame()

func showGameObjects():
	pizza.visible = true
	eatText.visible = true
	timer.setVisible(true)

func hideGameObjects():
	pizza.visible = false
	eatText.visible = false
	timer.setVisible(false)

func winGame():
	hideGameObjects()
	emit_signal("onGameWin")

func loseGame():
	hideGameObjects()
	emit_signal("onGameLoss")
