extends SlidingEntity

@onready var sprite_2d = $Sprite2D

var is_dead: bool = false
var is_teleporting: bool = false

func _process(_delta: float) -> void:
	if is_dead or is_teleporting:
		return
	sprite_2d.play("idle")

func start_move() -> void:
	super.start_move()
	Audio.moving_sound.play()

func start_action() -> void:
	super.start_action()
	if button:
		SlidingEntity.lock_game()
		button.update_button_state()
		SlidingEntity.unlock_game()
	check_underfoot_tile()

func check_underfoot_tile() -> void:
	for map_node in get_tree().get_nodes_in_group("gimmick_maps"):
		if map_node is TileMap:
			var local_pos = map_node.to_local(global_position)
			var tile_coords = map_node.local_to_map(local_pos)
			var source_id = map_node.get_cell_source_id(0, tile_coords)
			if source_id != -1:
				if map_node.has_method("trigger_script"):
					SlidingEntity.lock_game()
					map_node.trigger_script(self)
				break


func death() -> void:
	if is_dead:
		return
	is_dead = true
	GameManager.update_total_death()
	Audio.game_over_sound.play()
	sprite_2d.play("death")
	await sprite_2d.animation_finished
	TransitionScreen.target_scene_to_load = ""
	TransitionScreen.play_transition_screen()

func execute_teleport(target_pos: Vector2) -> void:
	if is_teleporting:
		return
	is_teleporting = true
	Audio.teleporting_sound.play()
	sprite_2d.play("teleporting")
	await sprite_2d.animation_finished
	global_position = target_pos
	Audio.appear_sound.play()
	sprite_2d.play_backwards("teleporting")
	await sprite_2d.animation_finished
	is_teleporting = false
	SlidingEntity.unlock_game()
