extends KinematicBody2D

# Grid and Speed vars
var speed : int = 256
var tile_size : int = 64

# Position Vars
var last_position : Vector2 = Vector2()
var target_position : Vector2 = Vector2()
var movedir : Vector2 = Vector2()

var tween_x : int = 0
var tween_y : int = 0

var can_move : bool = true;

# Onready vars
onready var ray : RayCast2D = $RayCast2D
onready var fall_tween : Tween = $Sprite/FallTween
onready var fall_timer : Timer = $FallTimer
onready var cam : Camera2D = $Camera
onready var cam_handler : Area2D = $CamHandler

# Initialize snapped to grid
func _ready():
	position = position.snapped(Vector2(tile_size, tile_size))
	last_position = position
	target_position = position
	
	
# Handles Movement
func _process(delta):
	if ray.is_colliding():
		position = last_position
		target_position = last_position
		if movedir != Vector2.ZERO:
			can_move = false
			
			fall_tween.interpolate_property($Sprite, "position", 
			Vector2(0, 0), Vector2(tween_x, tween_y),
			.75, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Camera/ScreenShake._start(0.5, 25, 2, 1);
			
			fall_tween.start()
			fall_timer.start(.5)
	elif can_move:
		position += speed * movedir * delta
		
	# Snaps the player if moved more than the intended
	if position.distance_to(last_position) >= tile_size:
		position = target_position
		
	# Idle
	if position == target_position:
		_get_movedir()
		last_position = position
		target_position += movedir * tile_size
	
	_camera_snap();


# Gets the direction the player wants to move
func _get_movedir():
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var down = Input.is_action_pressed("ui_down")
	var up = Input.is_action_pressed("ui_up")
	
	# Returns the direction as integers |  (-1, 0) if left
	movedir.x = -int(left) + int(right)
	movedir.y = -int(up) + int(down) 
	
	# Prevents Diagonals
	if movedir.x != 0 and movedir.y != 0:
		movedir = Vector2.ZERO
	
	# Move raycast to edge of the player in the movedir
	if movedir != Vector2.ZERO:
		ray.cast_to = movedir * tile_size / 2
		_rotate_sprite()
		if can_move:
			tween_x = movedir.x * tile_size
			tween_y = movedir.y * tile_size

# Returns the tween after fall
func _on_Timer_timeout():
	fall_timer.stop()
	fall_tween.interpolate_property($Sprite, "position", Vector2(tween_x, tween_y), 
	Vector2(0, 0), .75, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	fall_tween.start()
	$Camera/ScreenShake._start(0.5, 25, 2, 1);
	yield(fall_tween, "tween_all_completed")
	can_move = true;
	
func _rotate_sprite():
	if movedir == Vector2(-1, 0):
		$Sprite.set_frame(3)
	elif movedir == Vector2(1, 0):
		$Sprite.set_frame(1)
	elif movedir == Vector2(0, 1):
		$Sprite.set_frame(2)
	elif movedir == Vector2(0, -1):
		$Sprite.set_frame(0)

func _camera_snap():
	for area in cam_handler.get_overlapping_areas():
		if area.is_in_group("camera_snap"):
			cam.limit_left = area.position.x;
			cam.limit_right = area.position.x + 560 * area.scale.x;
			cam.limit_top = area.position.y;
			cam.limit_bottom = area.position.y + 360 * area.scale.y;

