extends Area2D

var is_following : bool = false;
var first_time : bool = true;

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
		if first_time:
			position = player.follower_pos
			target_position += movedir * player.tile_size
			first_time = not first_time
		
		
		if player.position != player.target_position:
			if player.can_move:
				position += player.speed * movedir * delta
			
			$AnimatedSprite.set_frame(player.last_index)
			if position.distance_to(last_position) >= player.tile_size:
				position = player.follower_pos
			
		if position == target_position:
			movedir = player.follower_dir
			last_position = position
			target_position += movedir * player.tile_size

func _check_col():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			body.rat_saved = true;
			is_following = true;