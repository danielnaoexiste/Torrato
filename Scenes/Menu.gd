extends Control

export(String, FILE, "*.tscn") var next_scene

var played : bool = false;

onready var play : TextureButton = $MarginContainer/VBoxContainer/PlayButton
onready var quit : TextureButton = $MarginContainer/VBoxContainer/QuitButton

# Called when the node enters the scene tree for the first time.
func _ready():
	play.grab_focus()

func _input(event):
	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_right"):
		played = false; 


func _process(delta):
	if play.is_hovered():
		play.grab_focus()
		if not played:
			$blip.play()
			played = true;
	if quit.is_hovered():
		if not played:
			$blip.play()
			played = true;
		quit.grab_focus()


func _on_PlayButton_pressed():
	$blip.play()
	scene_changer.change_scene(next_scene)


func _on_QuitButton_pressed():
	$blip.play()
	get_tree().quit()
