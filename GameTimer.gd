extends Timer

signal onRanOutOfTime
signal onReadyOver

onready var timeRemainingLabel = $TimeRemainingLabel
onready var readyLabel = $ReadyLabel

export var readyTime = 2
export var time_limit = 5

var ready = true

func setVisible (shouldBeVisible: bool):
	timeRemainingLabel.visible = shouldBeVisible

# Called when the node enters the scene tree for the first time.
func _ready():
	readyLabel.visible = true
	start(readyTime)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeRemainingLabel.text = str (ceil (time_left))


func _on_GameTimer_timeout():
	if ready:
		ready = false
		readyLabel.visible = false
		start(time_limit)
		emit_signal("onReadyOver")
	else:
		emit_signal("onRanOutOfTime")
