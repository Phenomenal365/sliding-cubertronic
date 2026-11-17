extends CharacterBody2D
class_name SlidingEntity

const TILE_SIZE = 64.0
const MOVE_SPEED = 1500.0

static var is_global_moving := false
static var active_movers := 0
static var is_game_locked := false
static var lock_count: int = 0
static var active_moving_entities: int = 0
static var total_entities: int = 0
static var arrived_count: int = 0
static var all_done: bool = false

@onready var wall_tile_map: TileMap = get_node_or_null("../WallTileMap") 
@onready var lock: TileMap = get_node_or_null("../lock")
@onready var stop: TileMap = get_node_or_null("../stop")
@onready var power_box: TileMap = get_node_or_null("../power_box")
@onready var cage: TileMap = get_node_or_null("../cage")
@onready var button: TileMap = get_node_or_null("../button")


var forced_dir: Vector2 = Vector2.ZERO

func apply_forced_direction(dir: Vector2) -> void:
	forced_dir = dir

static func lock_game() -> void:
	lock_count += 1
	is_game_locked = true

static func unlock_game() -> void:
	lock_count = max(0, lock_count - 1)
	if lock_count == 0:
		is_game_locked = false

func _ready() -> void:
	lock_game()
	is_global_moving = false
	active_movers = 0
	if not wall_tile_map:
		var root = get_tree().current_scene
		wall_tile_map = root.find_child("WallTileMap", true, false)
		if not wall_tile_map:
			wall_tile_map = root.find_child("TileMap", true, false)
	await get_tree().create_timer(1.5).timeout
	total_entities = get_tree().get_nodes_in_group("sliding_entities").size()
	unlock_game()

func _physics_process(_delta: float) -> void:
	if is_game_locked or is_global_moving:
		return

	var dir = Vector2.ZERO
	if forced_dir != Vector2.ZERO:
		dir = forced_dir
		forced_dir = Vector2.ZERO
	else:
		if Input.is_action_just_pressed("up"):
			dir = Vector2.UP
		elif Input.is_action_just_pressed("down"):
			dir = Vector2.DOWN
		elif Input.is_action_just_pressed("left"):
			dir = Vector2.LEFT
		elif Input.is_action_just_pressed("right"):
			dir = Vector2.RIGHT
	if dir != Vector2.ZERO:
		is_global_moving = true
		var entities = get_tree().get_nodes_in_group("sliding_entities")
		active_movers = entities.size()
		
		for entity in entities:
			if entity.has_method("grid_loop_slide"):
				entity.grid_loop_slide(dir, entities)

func can_entity_move_in_dir(occupying_entity: Node, move_dir: Vector2, all_entities: Array) -> bool:
	var current_pos = ((occupying_entity.global_position - Vector2(TILE_SIZE/2, TILE_SIZE/2)) / TILE_SIZE).round()
	var check_pos = current_pos + move_dir
	var so_o = 0
	var so_object = 0
	while true:
		var is_wall = false
		var world_p = check_pos * TILE_SIZE + Vector2(TILE_SIZE/2, TILE_SIZE/2)
		if wall_tile_map:
			var local_pos_wall = wall_tile_map.to_local(world_p)
			var tile_coords_wall = wall_tile_map.local_to_map(local_pos_wall)
			var source_id_wall = wall_tile_map.get_cell_source_id(0, tile_coords_wall)
			if source_id_wall == 1:
					is_wall = true
		if not is_wall and lock:
			var local_pos_lock = lock.to_local(world_p)
			var tile_coords_lock = lock.local_to_map(local_pos_lock)
			var source_id_lock = lock.get_cell_source_id(0, tile_coords_lock)
			if source_id_lock == 1:
				is_wall = true
		if not is_wall and power_box:
			var local_pos_power_box = power_box.to_local(world_p)
			var tile_coords_power_box = power_box.local_to_map(local_pos_power_box)
			var source_id_power_box = power_box.get_cell_source_id(0, tile_coords_power_box)
			if source_id_power_box == 1:
				is_wall = true
		if not is_wall and cage:
			var local_pos_cage = cage.to_local(world_p)
			var tile_coords_cage = cage.local_to_map(local_pos_cage)
			var source_id_cage = cage.get_cell_source_id(0, tile_coords_cage)
			if source_id_cage == 0:
					is_wall = true
		if is_wall:
			break
		so_o += 1
		var is_occupied = false
		for other in all_entities:
			if other == occupying_entity:
				continue
			var other_g_pos = ((other.global_position - Vector2(TILE_SIZE/2, TILE_SIZE/2)) / TILE_SIZE).round()
			if other_g_pos == check_pos:
				is_occupied = true
				break
		if is_occupied:
			so_object += 1
		check_pos += move_dir
	if so_o - so_object >= 1:
		return true
	else:
		return false

func grid_loop_slide(dir: Vector2, all_entities: Array) -> void:
	var current_grid_pos = ((global_position - Vector2(TILE_SIZE/2, TILE_SIZE/2)) / TILE_SIZE).round()
	var check_grid_pos = current_grid_pos + dir
	
	var so_o = 0
	var so_object = 0
	
	while true:
		var world_pos = check_grid_pos * TILE_SIZE + Vector2(TILE_SIZE/2, TILE_SIZE/2)
		var current_pos = current_grid_pos * TILE_SIZE + Vector2(TILE_SIZE/2, TILE_SIZE/2)
		var is_wall = false
		var is_caged = false
		if cage:
			var local_pos_cage = cage.to_local(current_pos)
			var tile_coords_cage = cage.local_to_map(local_pos_cage)
			var source_id_cage = cage.get_cell_source_id(0, tile_coords_cage)
			if source_id_cage == 0:
					is_caged = true
		if not is_caged:
			if wall_tile_map:
				var local_pos_wall = wall_tile_map.to_local(world_pos)
				var tile_coords_wall = wall_tile_map.local_to_map(local_pos_wall)
				var source_id_wall = wall_tile_map.get_cell_source_id(0, tile_coords_wall)
				if source_id_wall == 1:
						is_wall = true
			if not is_wall and cage:
				var local_pos_cage = cage.to_local(world_pos)
				var tile_coords_cage = cage.local_to_map(local_pos_cage)
				var source_id_cage = cage.get_cell_source_id(0, tile_coords_cage)
				if source_id_cage == 0:
						is_wall = true
			if not is_wall and lock:
				var local_pos_lock = lock.to_local(world_pos)
				var tile_coords_lock = lock.local_to_map(local_pos_lock)
				var source_id_lock = lock.get_cell_source_id(0, tile_coords_lock)
				if source_id_lock == 1:
					is_wall = true
			if not is_wall and power_box:
				var local_pos_power_box = power_box.to_local(world_pos)
				var tile_coords_power_box = power_box.local_to_map(local_pos_power_box)
				var source_id_power_box = power_box.get_cell_source_id(0, tile_coords_power_box)
				if source_id_power_box == 1:
					is_wall = true
			if not is_wall and stop:
				var local_pos_stop = stop.to_local(world_pos)
				var tile_coords_stop = stop.local_to_map(local_pos_stop)
				var source_id_stop = stop.get_cell_source_id(0, tile_coords_stop)
				if source_id_stop == 1:
					var occupying_entity = null
					var stop_grid_pos = ((world_pos - Vector2(TILE_SIZE/2, TILE_SIZE/2)) / TILE_SIZE).round()
					for other in all_entities:
						if other == self:
							continue
						var other_grid_pos = ((other.global_position - Vector2(TILE_SIZE/2, TILE_SIZE/2)) / TILE_SIZE).round()
						if other_grid_pos == stop_grid_pos:
							occupying_entity = other
							break
					if occupying_entity != null and not can_entity_move_in_dir(occupying_entity, dir, all_entities):
						is_wall = true
					else:
						so_o +=1
						is_wall = true
		if is_wall or is_caged:
			break
			
		so_o += 1
		
		var is_occupied = false
		for other in all_entities:
			if other == self:
				continue
			var other_grid_pos = ((other.global_position - Vector2(TILE_SIZE/2, TILE_SIZE/2)) / TILE_SIZE).round()
			if other_grid_pos == check_grid_pos:
				is_occupied = true
				break
				
		if is_occupied:
			so_object += 1
		
		check_grid_pos += dir
		
		if so_o > 100:
			break
	start_move()
	var free_steps = max(0, so_o - so_object)
	var target_pos = global_position
	if free_steps > 0:
		target_pos = global_position + dir * (free_steps * TILE_SIZE)
	else:
		finish_one_mover()
		return
	var distance = global_position.distance_to(target_pos)
	if distance <= 0:
		finish_one_mover()
		return
	var duration = distance / MOVE_SPEED
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_pos, duration)
	tween.tween_callback(func():
		global_position = target_pos
		
		finish_one_mover()
	)
func start_move() -> void:
	active_moving_entities += 1

func finish_one_mover() -> void:
	arrived_count += 1
	if arrived_count == total_entities:
		arrived_count = 0
		all_done = true
		is_global_moving = false
	if all_done:
		var entities = get_tree().get_nodes_in_group("sliding_entities")
		for entity in entities:
			if entity.has_method("start_action"):
				entity.start_action()

func start_action() -> void:
	all_done = false
