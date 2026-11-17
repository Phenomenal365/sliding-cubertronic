extends TileMap

const ARROW_DIRECTIONS = {
	0: Vector2.DOWN,
	1: Vector2.LEFT,
	2: Vector2.RIGHT,
	3: Vector2.UP
}

func trigger_script(entity: Node2D) -> void:
	var local_pos = to_local(entity.global_position)
	var tile_coords = local_to_map(local_pos)
	var cell_id = get_cell_source_id(0, tile_coords)
	if ARROW_DIRECTIONS.has(cell_id):
		var target_dir = ARROW_DIRECTIONS[cell_id]
		if entity.has_method("apply_forced_direction"):
			entity.apply_forced_direction(target_dir)
	SlidingEntity.unlock_game()
