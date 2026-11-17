extends Control
@onready var fullscreen_mode: CheckButton = $fullscreen_mode
@onready var windowed_mode: CheckButton = $windowed_mode


func _ready() -> void:
	var current_screen_mode = SaveManager.game_data.get("fullscreen")
	_apply_screen(current_screen_mode)
	match current_screen_mode:
		1: fullscreen_mode.button_pressed = true
		0: windowed_mode.button_pressed = true
	fullscreen_mode.toggled.connect(func(toggled): if toggled: _apply_screen(1))
	windowed_mode.toggled.connect(func(toggled): if toggled: _apply_screen(0))
	

func _apply_screen(target_screen: int) -> void:
	if target_screen == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	SaveManager.game_data["fullscreen"] = target_screen
	SaveManager.save_game()
