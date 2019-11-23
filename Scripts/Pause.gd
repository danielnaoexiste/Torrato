extends Control

# ignore-warning: unused_argument
func _input(event):
	if Input.is_action_just_pressed("ui_pause"):
		get_tree().paused = not get_tree().paused;
		visible = not visible;