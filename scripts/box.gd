extends SlidingEntity

func start_action() -> void:
	super.start_action()
	check_underfoot_tile()

func check_underfoot_tile() -> void:
	for map_node in get_tree().get_nodes_in_group("universal_gimmick_maps"):
		if map_node is TileMap:
			var local_pos = map_node.to_local(global_position)
			var tile_coords = map_node.local_to_map(local_pos)
			if map_node.get_cell_source_id(0, tile_coords) != -1:
				if map_node.has_method("trigger_script"):
					SlidingEntity.lock_game()
					map_node.trigger_script(self)
				break
