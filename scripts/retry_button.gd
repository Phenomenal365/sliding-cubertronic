extends Button
@onready var player: CharacterBody2D = $"../player"
@onready var menu_button: Button = $"../MenuButton"
@onready var out_button: Button = $"../OutButton"

func _on_pressed() -> void:
	disabled = true
	menu_button.disabled = true
	out_button.disabled = true
	if player.has_method("death"):
		player.death()
