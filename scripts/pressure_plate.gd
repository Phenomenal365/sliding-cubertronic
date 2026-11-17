extends TileMap
@onready var lock = get_node("../lock")
var is_triggered: bool = false
func trigger_script(player: Node2D) ->void:
	if is_triggered:
		SlidingEntity.unlock_game()
		return
	is_triggered = true
	var local_pos = to_local(player.global_position)
	var tile_coords = local_to_map(local_pos)
	set_cell(0, tile_coords, 0, Vector2i(0,1))
	if lock and lock.has_method("unlock"):
		lock.unlock()
