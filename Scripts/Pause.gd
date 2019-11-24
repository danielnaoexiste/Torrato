extends Control

export(String, FILE, "*.tscn") var next_scene
onready var label : Label = $timerpelado/Label
export (NodePath) var world 
onready var ui_label : Label = get_parent().get_node("UI").get_node("Label")

onready var menu : TextureButton = $timerpelado/VBoxContainer/HBoxContainer/Menu
onready var sair : TextureButton = $timerpelado/VBoxContainer/HBoxContainer/Sair
onready var reset : TextureButton = $timerpelado/VBoxContainer/HBoxContainer/Reset

func _ready():
	connect("time_formated", get_parent().get_node("UI"), "_format_time")
	world = get_node(world)
	menu.grab_focus()

# ignore-warning: unused_argument
func _input(event):
	if Input.is_action_just_pressed("ui_pause"):
		_format_time()
		get_tree().paused = not get_tree().paused;
		visible = not visible;
		menu.grab_focus()

func _process(delta):
	if menu.is_hovered():
		menu.grab_focus()
	if sair.is_hovered():
		sair.grab_focus()
	if reset.is_hovered():
		reset.grab_focus()


func _format_time():
	label.text = ui_label.text

func _on_Menu_pressed():
	scene_changer.change_scene(next_scene);


func _on_Sair_pressed():
	get_tree().quit()

func _on_Reset_pressed():
	get_tree().paused = not get_tree().paused;
	get_tree().reload_current_scene()
