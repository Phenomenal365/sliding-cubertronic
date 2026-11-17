extends Control

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var button: Button = $CanvasLayer/Button

func _ready() -> void:
	canvas_layer.visible = false


func _on_button_pressed() -> void:
	SlidingEntity.unlock_game()
	canvas_layer.visible = false
