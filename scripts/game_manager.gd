extends Node

var current_level_index: int = 1
var highest_level_index: int
var total_death: int
var game_beaten: int

var level_paths: Array[String] = [
	"res://scenes/levels/level_1.tscn",
	"res://scenes/levels/level_2.tscn",
	"res://scenes/levels/level_3.tscn",
	"res://scenes/levels/level_4.tscn",
	"res://scenes/levels/level_5.tscn",
	"res://scenes/levels/level_6.tscn",
	"res://scenes/levels/level_7.tscn",
	"res://scenes/levels/level_8.tscn",
	"res://scenes/levels/level_9.tscn",
	"res://scenes/levels/level_10.tscn",
	"res://scenes/levels/level_11.tscn",
	"res://scenes/levels/level_12.tscn",
	"res://scenes/levels/level_13.tscn",
	"res://scenes/levels/level_14.tscn",
	"res://scenes/levels/level_15.tscn",
	"res://scenes/levels/level_16.tscn",
	"res://scenes/levels/level_17.tscn",
	"res://scenes/levels/level_18.tscn",
	"res://scenes/levels/level_19.tscn",
	"res://scenes/levels/level_20.tscn",
	"res://scenes/levels/level_21.tscn",
	"res://scenes/levels/level_22.tscn",
	"res://scenes/levels/level_23.tscn",
	"res://scenes/levels/level_24.tscn",
	"res://scenes/levels/level_25.tscn",
	"res://scenes/levels/level_26.tscn",
	"res://scenes/levels/level_27.tscn",
	"res://scenes/levels/level_28.tscn",
	"res://scenes/levels/level_29.tscn",
	"res://scenes/levels/level_30.tscn",
	"res://scenes/levels/level_31.tscn",
	"res://scenes/levels/level_32.tscn",
	"res://scenes/levels/level_33.tscn",
	"res://scenes/levels/level_34.tscn",
	"res://scenes/levels/level_35.tscn",
	"res://scenes/levels/level_36.tscn",
	"res://scenes/levels/level_37.tscn",
	"res://scenes/levels/level_38.tscn",
	"res://scenes/levels/level_39.tscn",
	"res://scenes/levels/level_40.tscn",
	"res://scenes/levels/level_41.tscn",
	"res://scenes/levels/level_42.tscn",
	"res://scenes/levels/level_43.tscn",
	"res://scenes/levels/level_44.tscn",
	"res://scenes/levels/level_45.tscn",
	"res://scenes/levels/level_46.tscn",
	"res://scenes/levels/level_47.tscn",
	"res://scenes/levels/level_48.tscn",
	"res://scenes/levels/level_49.tscn",
	"res://scenes/levels/level_50.tscn",
	"res://scenes/levels/level_51.tscn",
	"res://scenes/levels/level_52.tscn",
	"res://scenes/levels/level_53.tscn",
	"res://scenes/levels/level_54.tscn",
	"res://scenes/levels/level_55.tscn",
	"res://scenes/levels/level_56.tscn",
	"res://scenes/levels/level_57.tscn",
	"res://scenes/levels/level_58.tscn",
	"res://scenes/levels/level_59.tscn",
	"res://scenes/levels/level_60.tscn"
	
]

func _ready() -> void:
	highest_level_index = SaveManager.game_data["unlocked_level"]
	total_death = SaveManager.game_data["total_death"]
	game_beaten = SaveManager.game_data["beaten"]

func update_total_death() -> void:
	total_death += 1
	SaveManager.game_data["total_death"] = total_death
	SaveManager.save_game()

func change_current_level_index(index: int) -> void:
	current_level_index = index

func change_highest_level_index(index: int) -> void:
	highest_level_index = index

func get_game_beaten() -> int:
	return game_beaten

func get_total_death() -> int:
	return total_death

func get_highest_level_index() ->int:
	return highest_level_index

func get_current_level_index() ->int:
	return current_level_index

func update_highest_level_index() -> void:
	if current_level_index == highest_level_index:
		highest_level_index += 1
		SaveManager.game_data["unlocked_level"] = highest_level_index
		SaveManager.save_game()

func update_game_beaten() -> void:
	game_beaten = 1
	SaveManager.game_data["beaten"] = game_beaten
	SaveManager.save_game()

func go_to_next_level() -> String:
	current_level_index += 1
	if current_level_index <= level_paths.size():
		return level_paths[current_level_index - 1]
	return ""

func get_current_level_path() -> String:
	return level_paths[current_level_index - 1]
