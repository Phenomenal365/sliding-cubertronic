extends Button

func _on_pressed() -> void:
	SlidingEntity.lock_game()
	SettingsScene.canvas_layer.visible = true
