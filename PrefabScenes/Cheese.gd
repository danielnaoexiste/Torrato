extends Area2D

onready var level : Node = get_tree().get_root().get_child(1)

signal cheese_colected

#warning-ignore: unused_argument
func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			level.cheese += 1
			body.speed += 32
			print("Pegou o qejo")
			emit_signal("cheese_colected")
			queue_free()