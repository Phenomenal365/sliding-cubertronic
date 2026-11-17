extends TileMap

func open_cages() -> void:
	var all_cage_cells = get_used_cells(0)
	for cell_coords in all_cage_cells:
		if get_cell_source_id(0, cell_coords) != -1:
			set_cell(0, cell_coords, 1, Vector2i(0, 0))

func close_cages() -> void:
	var all_cage_cells = get_used_cells(0)
	for cell_coords in all_cage_cells:
		if get_cell_source_id(0, cell_coords) != -1:
			set_cell(0, cell_coords, 0, Vector2i(0, 0))
