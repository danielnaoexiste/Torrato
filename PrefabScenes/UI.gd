extends Control

var level_time : int = 125

# Onready vars
onready var label : Label = $Label
onready var timer : Timer = $Timer

var seconds : int 
var minutes : int


func _ready():
	print("aoooooo")
	timer.wait_time = level_time
	seconds = level_time
	$Timer.start(1)
	
# warning-ignore:unused_argument
func _process(delta):
	while (seconds >= 60):
		minutes += 1;
		seconds -= 60;
		print("Min:", minutes, "sec", seconds)
	
	label.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)

func _on_Timer_timeout():
	seconds -= 1;
	if seconds < 0:
		if minutes  <= 0:
			# Reinicia a fase aqui
			get_tree().paused = not get_tree().paused;
		else:
			minutes -= 1
			seconds = 59
