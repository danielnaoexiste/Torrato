extends Control

signal time_formated

# Onready vars
onready var label : Label = $Label
onready var cheese_label : Label = $CheeseLabel
onready var timer : Timer = $Timer
export(NodePath) onready var world

var seconds : int 
var minutes : int


func _ready():
	world = get_node(world)
	timer.wait_time = world.level_time
	seconds = world.level_time
	$Timer.start(1)
	cheese_label.text = "0X"
	
# warning-ignore:unused_argument
func _process(delta):
	while (seconds >= 60):
		minutes += 1;
		seconds -= 60;
		print("Min:", minutes, "sec", seconds)
	emit_signal("time_formated")
	label.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	cheese_label.text = str(world.cheese) + "X"

func _on_Timer_timeout():
	seconds -= 1;
	if seconds < 0:
		if minutes  <= 0:
			get_tree().reload_current_scene()
		else:
			minutes -= 1
			seconds = 59
