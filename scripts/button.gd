extends TileMap

@export var cage_tile_map: TileMap 
@onready var cage: TileMap = get_node_or_null("../cage")

const TILE_SIZE = 64
var button_cell: Vector2i = Vector2i(-1, -1)
var is_button_pressed: bool = false

func _ready() -> void:
	var cells = get_used_cells(0)
	if cells.is_empty():
		return
	button_cell = cells[0]


func update_button_state() -> void:
	var button_world_pos = map_to_local(button_cell)
	@warning_ignore("integer_division")
	var button_grid_pos = ((button_world_pos - Vector2(TILE_SIZE/2, TILE_SIZE/2)) / TILE_SIZE).round()
	var is_occupied = false
	var all_entities = get_tree().get_nodes_in_group("sliding_entities")
	for entity in all_entities:
		@warning_ignore("integer_division")
		var entity_grid_pos = ((entity.global_position - Vector2(TILE_SIZE/2, TILE_SIZE/2)) / TILE_SIZE).round()
		if entity_grid_pos == button_grid_pos:
			is_occupied = true
			break
	if is_occupied:
		if not is_button_pressed:
			Audio.activate_sound.play()
			set_cell(0, button_cell, 0, Vector2i(0, 1))
			cage.open_cages()
			is_button_pressed = true
	else:
		if is_button_pressed:
			set_cell(0, button_cell, 0, Vector2i(0, 0))
			cage.close_cages()
			is_button_pressed= false
