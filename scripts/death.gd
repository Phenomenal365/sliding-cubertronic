extends TileMap
@onready var retry_button: Button = $"../RetryButton"
@onready var out_button: Button = $"../OutButton"
@onready var menu_button: Button = $"../MenuButton"


func trigger_script(player: Node2D) -> void:
	retry_button.disabled = true
	out_button.disabled = true
	menu_button.disabled = true
	if player.has_method("death"):
		player.death()
