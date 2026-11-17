extends CanvasLayer

@onready var total_death_label: Label = $ColorRect/total_death_label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_end_screen() -> void:
	total_death_label.text = "You have died and reset %d times" % GameManager.get_total_death()
	animation_player.play("ending")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/UI-UX/main_menu.tscn")
	await get_tree().create_timer(55.5).timeout
	Audio.screen_slide_sound.play()
	await animation_player.animation_finished
	SlidingEntity.unlock_game()
