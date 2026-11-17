extends CanvasLayer

@onready var anim_player = $AnimationPlayer
@onready var label: Label = $ColorRect/Label

var target_scene_to_load: String = ""

func play_transition_screen() -> void:
	label.text = "Level %d" % GameManager.current_level_index
	if anim_player.has_animation("scene_change"):
		anim_player.play("scene_change")
	await get_tree().create_timer(1.5).timeout
	if target_scene_to_load != "":
		get_tree().change_scene_to_file(target_scene_to_load)
	else:
		get_tree().reload_current_scene()
	target_scene_to_load = ""
	await get_tree().create_timer(1).timeout
	Audio.screen_slide_sound.play()
	await anim_player.animation_finished
	SlidingEntity.unlock_game()
