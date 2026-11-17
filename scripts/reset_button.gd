extends Button
@onready var canvas_layer_2: CanvasLayer = $"../../CanvasLayer2"
@onready var canvas_layer: CanvasLayer = $".."

func _ready() -> void:
	canvas_layer_2.visible = false

func _on_pressed() -> void:
	canvas_layer_2.visible = true
	canvas_layer.visible = false

func _on_yes_button_pressed() -> void:
	GameManager.change_highest_level_index(1)
	SaveManager.game_data["unlocked_level"] = 1
	SaveManager.game_data["total_death"] = 0
	SaveManager.game_data["beaten"] = 0
	SaveManager.save_game()
	canvas_layer_2.visible = false

func _on_no_button_pressed() -> void:
	canvas_layer_2.visible = false
	canvas_layer.visible = true
