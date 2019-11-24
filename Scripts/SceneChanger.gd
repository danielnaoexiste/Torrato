extends CanvasLayer

signal scene_changed()

onready var anim_player : AnimationPlayer = $AnimationPlayer
onready var black : ColorRect = $Control/ColorRect

func change_scene(path, delay = .5):
	yield(get_tree().create_timer(delay), "timeout")
	anim_player.play("Fade")
	yield(anim_player, "animation_finished")
	get_tree().change_scene(path)
	anim_player.play_backwards("Fade")
	yield(anim_player, "animation_finished")
	emit_signal("scene_changed")