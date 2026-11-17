extends TileMap

@onready var electricity: TileMap = get_node_or_null("../electricity")
@onready var power_box: TileMap = get_node_or_null("../power_box")

var activated_switches: bool = false
func trigger_script(player: Node2D) -> void:
	var local_pos = to_local(player.global_position)
	var tile_coords = local_to_map(local_pos)
	if activated_switches:
		SlidingEntity.unlock_game()
		return
	activated_switches = true
	Audio.power_off_sound.play()
	set_cell(0, tile_coords, 0, Vector2i(0, 0))
	if electricity:
		electricity.queue_free()
	if power_box:
		for cell in power_box.get_used_cells(0):
			power_box.set_cell(0, cell, 1, Vector2i(0, 1))
	SlidingEntity.unlock_game()
