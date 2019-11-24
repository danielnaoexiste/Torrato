extends Control

export(String, FILE, "*.tscn") var next_scene

onready var play : TextureButton = $MarginContainer/VBoxContainer/PlayButton
onready var quit : TextureButton = $MarginContainer/VBoxContainer/QuitButton
# Called when the node enters the scene tree for the first time.
func _ready():
	play.grab_focus()

func _process(delta):
	if play.is_hovered():
		play.grab_focus()
	if quit.is_hovered():
		quit.grab_focus()


func _on_PlayButton_pressed():
	scene_changer.change_scene(next_scene)


func _on_QuitButton_pressed():
	get_tree().quit()
