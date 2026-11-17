extends CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func play_back_scene() -> void:
	animation_player.play("back_scene")
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://scenes/UI-UX/main_menu.tscn")
	await get_tree().create_timer(1).timeout
	Audio.screen_slide_sound.play()
	await animation_player.animation_finished
