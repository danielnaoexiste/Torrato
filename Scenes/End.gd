extends Control

export(String, FILE, "*.tscn") var next_scene

func _input(event):
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_pause"):
		$blip.play()
		scene_changer.change_scene(next_scene)