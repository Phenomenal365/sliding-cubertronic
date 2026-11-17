extends Control
@onready var _30_fps: CheckButton = $"30fps"
@onready var _60_fps: CheckButton = $"60fps"
@onready var _90_fps: CheckButton = $"90fps"
@onready var _120_fps: CheckButton = $"120fps"

func _ready() -> void:
	var current_fps = SaveManager.game_data.get("fps")
	match current_fps:
		30: _30_fps.button_pressed = true
		60: _60_fps.button_pressed = true
		90: _90_fps.button_pressed = true
		120: _120_fps.button_pressed = true
	_30_fps.toggled.connect(func(toggled): if toggled: _apply_fps(30))
	_60_fps.toggled.connect(func(toggled): if toggled: _apply_fps(60))
	_90_fps.toggled.connect(func(toggled): if toggled: _apply_fps(90))
	_120_fps.toggled.connect(func(toggled): if toggled: _apply_fps(120))

func _apply_fps(target_fps: int) -> void:
	Engine.max_fps = target_fps
	SaveManager.game_data["fps"] = target_fps
	SaveManager.save_game()
