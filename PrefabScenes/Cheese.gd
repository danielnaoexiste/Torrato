extends Area2D

export(NodePath) var world

signal cheese_colected

func _ready():
	world = get_node(world)

#warning-ignore: unused_argument
func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			world.cheese += 1
			body.speed += 32
			print("Pegou o qejo")
			emit_signal("cheese_colected")
			queue_free()