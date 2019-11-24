extends Sprite

# modulates BG through time
var color : Color = Color.coral;
var next_color : Color = Color.crimson;

onready var tween : Tween = $Tween

func _process(delta):
	$AnimationPlayer.play("Glow")
	yield($AnimationPlayer, "animation_finished")