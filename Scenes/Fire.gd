extends Area2D

onready var timer : Timer = $Timer
onready var col : CollisionShape2D = $CollisionShape2D

func _ready():
	timer.start(3)
	col.disabled = true;
	visible = not visible
	
func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_tree().reload_current_scene()

func _on_Timer_timeout():
	col.disabled = not col.disabled
	visible = not visible
	timer.stop()
	timer.start(3)
