extends TileMap
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var lock_coords: Vector2i

func _ready() -> void:
	for cell in get_used_cells(0):
		if get_cell_source_id(0, cell) == 1:
			lock_coords = cell
			if animated_sprite_2d:
				animated_sprite_2d.position = Vector2i(cell * 64 + Vector2i(32, 32))
			break
func unlock():
	Audio.unlocking_sound.play()
	if animated_sprite_2d:
		animated_sprite_2d.visible = true
		animated_sprite_2d.play("unlock")
		await animated_sprite_2d.animation_finished
	if animated_sprite_2d:
		animated_sprite_2d.visible = false
	SlidingEntity.unlock_game()
	queue_free()
