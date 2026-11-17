extends Control




func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI-UX/level_selection_scene.tscn")

func _on_setting_button_pressed() -> void:
	SettingsScene.canvas_layer.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()
