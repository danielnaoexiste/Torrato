extends CanvasLayer

signal scene_changed()


onready var anim_player : AnimationPlayer = $AnimationPlayer
onready var black : ColorRect = $Control/ColorRect

func change_scene(path, delay = .2):
	yield(get_tree().create_timer(delay), "timeout")
	anim_player.play("Fade")
	yield(get_tree().create_timer(delay), "timeout")
	get_tree().change_scene(path)
	#anim_player.play_backwards("Fade")
