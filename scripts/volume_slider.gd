extends HSlider
@onready var volume_index_label: Label = $"../Volume_index_label"

func _ready() -> void:
	min_value = 0.0
	max_value = 1.0
	step = 0.01
	value = SaveManager.game_data["volume"]
	var percentage_value = value * 100
	volume_index_label.text = "%d" % percentage_value
	value_changed.connect(_on_value_changed)

func _on_value_changed(new_value: float) -> void:
	Audio.set_global_volume(new_value)
	var percentage_value = new_value * 100
	volume_index_label.text = "%d" % percentage_value
	SaveManager.game_data["volume"] = new_value
	SaveManager.save_game()
