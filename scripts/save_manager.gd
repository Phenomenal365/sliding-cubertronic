extends Node

const SAVE_PATH = "user://savegame.cfg"

var game_data = {
	"volume": 0.7,
	"fps": 90,
	"fullscreen": 1,
	"unlocked_level": 1,
	"total_death": 0,
	"beaten": 0
}

func _init() -> void:
	load_game()

func save_game() -> void:
	var config = ConfigFile.new()
	config.set_value("settings", "volume", game_data["volume"])
	config.set_value("settings", "fps", game_data["fps"])
	config.set_value("settings", "fullscreen", game_data["fullscreen"])
	config.set_value("progress", "unlocked_level", game_data["unlocked_level"])
	config.set_value("progress", "total_death", game_data["total_death"])
	config.set_value("progress", "beaten", game_data["beaten"])
	config.save(SAVE_PATH)

func load_game() -> void:
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)
	if err != OK:
		return
	game_data["volume"] = config.get_value("settings", "volume", 0.7)
	game_data["fps"] = config.get_value("settings", "fps", 90)
	game_data["fullscreen"] = config.get_value("settings", "fullscreen", 1)
	game_data["unlocked_level"] = config.get_value("progress", "unlocked_level", 1)
	game_data["total_death"] = config.get_value("progress", "total_death", 0)
	game_data["beaten"] = config.get_value("progress", "beaten", 0)
