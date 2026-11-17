extends Node

@onready var moving_sound: AudioStreamPlayer = $moving_sound
@onready var button_click_sound: AudioStreamPlayer = $button_click_sound
@onready var win_sound: AudioStreamPlayer = $win_sound
@onready var game_over_sound: AudioStreamPlayer = $game_over_sound
@onready var teleporting_sound: AudioStreamPlayer = $teleporting_sound
@onready var appear_sound: AudioStreamPlayer = $appear_sound
@onready var unlocking_sound: AudioStreamPlayer = $unlocking_sound
@onready var power_off_sound: AudioStreamPlayer = $power_off_sound
@onready var activate_sound: AudioStreamPlayer = $activate_sound
@onready var screen_slide_sound: AudioStreamPlayer = $screen_slide_sound

var original_volumes: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		original_volumes[child] = child.volume_db
	set_global_volume(SaveManager.game_data["volume"])
	get_tree().node_added.connect(_on_node_added)
	call_deferred("_scan_existing_nodes", get_tree().root)

func set_global_volume(slider_value: float) -> void:
	for child in get_children():
		var base_db = original_volumes[child]
		if slider_value <= 0.0:
			child.volume_db = -80.0
		else:
			var scale_db = linear_to_db(slider_value)
			child.volume_db = base_db + scale_db

func _on_node_added(node: Node) -> void:
	if node is BaseButton:
		_connect_button(node)

func _scan_existing_nodes(root: Node) -> void:
	if root is BaseButton:
		_connect_button(root)
	for child in root.get_children():
		_scan_existing_nodes(child)

func _connect_button(button: BaseButton) -> void:
	if not button.pressed.is_connected(_play_button_click):
		button.pressed.connect(_play_button_click)

func _play_button_click() -> void:
	button_click_sound.play()
