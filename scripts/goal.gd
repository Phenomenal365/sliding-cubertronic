extends TileMap

func trigger_script(_player: Node2D) -> void:
	Audio.win_sound.play()
	GameManager.update_highest_level_index()
	TransitionScreen.target_scene_to_load = GameManager.go_to_next_level()
	var check_end = GameManager.get_current_level_index()
	if check_end > 60:
		SaveManager.game_data["total_death"] = 60
		SaveManager.save_game()
		var check_beaten = GameManager.get_game_beaten()
		if check_beaten != 0:
			GameManager.update_game_beaten()
			BackScene.play_back_scene()
			SlidingEntity.unlock_game()
			return
		GameManager.update_game_beaten()
		EndScreen.play_end_screen()
		return
	TransitionScreen.play_transition_screen()
