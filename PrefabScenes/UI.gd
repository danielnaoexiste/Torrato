extends Control

signal time_formated

# Onready vars
onready var label : Label = $Label
onready var timer : Timer = $Timer

var seconds : int 
var minutes : int


func _ready():
	var level_time = get_tree().get_root().get_child(1).level_time
	timer.wait_time = level_time
	print(level_time)
	seconds = level_time
	$Timer.start(1)
	
# warning-ignore:unused_argument
func _process(delta):
	while (seconds >= 60):
		minutes += 1;
		seconds -= 60;
		print("Min:", minutes, "sec", seconds)
	emit_signal("time_formated")
	label.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)


func _on_Timer_timeout():
	seconds -= 1;
	if seconds < 0:
		if minutes  <= 0:
			get_tree().reload_current_scene()
		else:
			minutes -= 1
			seconds = 59
