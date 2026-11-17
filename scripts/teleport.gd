extends TileMap

const TILE_SIZE = 64.0

@onready var land_tile_map: TileMap = get_node_or_null("../landing")

const TELEPORT_PAIRS = {
	0: 0,
	1: 1
}

func trigger_script(player: Node2D) -> void:
	if not land_tile_map:
		SlidingEntity.unlock_game()
		return
	var local_pos = to_local(player.global_position)
	var tile_coords = local_to_map(local_pos)
	var source_id = get_cell_source_id(0, tile_coords)
	var target_land_id = TELEPORT_PAIRS[source_id]
	var land_coords = Vector2(-999, -999)
	for cell in land_tile_map.get_used_cells(0):
		if land_tile_map.get_cell_source_id(0, cell) == target_land_id:
			land_coords = cell
			break
	var target_world_pos = land_tile_map.map_to_local(land_coords)
	var all_entities = get_tree().get_nodes_in_group("sliding_entities")
	var is_occupied = false
	for other in all_entities:
		var other_grid_pos = ((other.global_position - Vector2(TILE_SIZE/2, TILE_SIZE/2)) / TILE_SIZE).round()
		if other_grid_pos == Vector2(land_coords):
			is_occupied = true
			break
	if is_occupied:
		SlidingEntity.unlock_game()
		return
	if player.has_method("execute_teleport"):
		player.execute_teleport(target_world_pos)
