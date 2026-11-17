extends Button
@onready var menu_button: Button = $"../MenuButton"
@onready var retry_button: Button = $"../RetryButton"


func _on_pressed() -> void:
	disabled = true
	menu_button.disabled = true
	retry_button.disabled = true
	BackScene.play_back_scene()
