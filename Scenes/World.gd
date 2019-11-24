extends Node2D

export(int) var level_time : int = 75
export(int) var cheese : int = 0

func _ready():
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_restart"):
		get_tree().reload_current_scene()