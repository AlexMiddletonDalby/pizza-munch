extends Node2D

onready var winText = $WinText
onready var winWario = $WinWario
onready var loseText = $LoseText
onready var loseWario = $LoseWario

func _on_main_onGameWin():
	winText.visible = true
	winWario.visible = true
	loseText.visible = false
	loseWario.visible = false

func _on_main_onGameLoss():
	loseText.visible = true
	loseWario.visible = true
	winText.visible = false
	winWario.visible = false
