extends Sprite

# Grid and Speed vars
var speed : int = 256
var tile_size : int = 64

# Position Vars
var last_position : Vector2 = Vector2()
var target_position : Vector2 = Vector2()
var movedir : Vector2 = Vector2()

# Initialize snapped to grid
func _ready():
	position = position.snapped(Vector2(tile_size, tile_size))
	last_position = position
	target_position = position

# Handles Movement
func _process(delta):
	position += speed * movedir * delta
	
	# Snaps the player if moved more than the intended
	if position.distance_to(last_position) >= tile_size:
		position = target_position
		
	# Idle
	if position == target_position:
		_get_movedir()
		last_position = position
		target_position += movedir * tile_size

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
