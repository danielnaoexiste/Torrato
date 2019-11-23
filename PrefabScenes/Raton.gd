extends Area2D

var is_following : bool = false;
export(NodePath) onready var player_path : NodePath
var player : KinematicBody2D

var movedir : Vector2 = Vector2()
var last_position : Vector2 = Vector2()
var target_position : Vector2 = Vector2()

func _ready():
	player = get_node(player_path);
	position = position.snapped(Vector2(64, 64))
	last_position = position
	target_position = position

func _process(delta):
	_check_col()
	if is_following:
		print("Seguindo")
		target_position = player.last_position
		last_position = position
		position += player.speed * delta * player.movedir
		if player.position != player.target_position:
			last_position = position
			position += target_position
		
		if position.distance_to(last_position) >= 64:
			position = target_position
	
func _check_col():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			is_following = true;
