extends Control

@onready var part_1_button: Button = $ColorRect/Part1Button
@onready var part_2_button: Button = $ColorRect/Part2Button
@onready var grid_part_1: GridContainer = $ColorRect/GridPart1
@onready var grid_part_2: GridContainer = $ColorRect/GridPart2


var highest_unlocked_level: int = GameManager.get_highest_level_index()

func _ready() -> void:
	show_part_1()
	update_level_buttons(grid_part_1, 1, 30)
	update_level_buttons(grid_part_2, 31, 60)

func update_level_buttons(grid: GridContainer, start_level: int, end_level: int) -> void:
	var buttons = grid.get_children()
	for i in range(buttons.size()):
		var level_num = start_level + i
		if level_num > end_level:
			break
		var btn = buttons[i] as Button
		if btn:
			if level_num <= highest_unlocked_level:
				btn.disabled = false
				var level_path = "res://scenes/levels/level_%d.tscn" % level_num
				if not btn.pressed.is_connected(_on_level_button_pressed):
					btn.pressed.connect(Callable(self, "_on_level_button_pressed").bind(level_num, level_path))
			else:
				btn.disabled = true

func _on_level_button_pressed(level_num: int, path: String) -> void:
	GameManager.change_current_level_index(level_num)
	TransitionScreen.target_scene_to_load = path
	SlidingEntity.lock_game()
	TransitionScreen.play_transition_screen()

func _on_part_1_button_pressed() -> void:
	grid_part_1.visible = true
	grid_part_2.visible = false
	part_1_button.visible = false
	part_2_button.visible = true

func _on_part_2_button_pressed() -> void:
	grid_part_1.visible = false
	grid_part_2.visible = true
	part_1_button.visible = true
	part_2_button.visible = false

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI-UX/main_menu.tscn")

func show_part_1() -> void:
	grid_part_1.visible = true
	grid_part_2.visible = false
	part_1_button.visible = false
	part_2_button.visible = true
