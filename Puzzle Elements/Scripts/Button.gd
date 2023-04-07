tool
extends Area2D

class_name FloorButton

export var button_colour : Color = Color.red setget _set_colour
export var emitter_id : int = 0
export var use_mels_button : bool = false setget _set_button_type

export var turn_off_delay : float = 0

var base_texture_x : int = 0
var button_pressed : bool = false setget _set_button_pressed

func _ready():
	$ButtonSpr.modulate = button_colour

func _on_button_pressed(_body: Node) -> void:
	self.button_pressed = true
	get_tree().call_group("puzzle_signal_listeners", "_on_activate_signal", emitter_id)

func _on_button_released(_body: Node) -> void:
	if turn_off_delay <= 0:
		send_released_signal()
	else:
		$Timer.wait_time = turn_off_delay
		$Timer.start()

func send_released_signal():
	self.button_pressed = false
	get_tree().call_group("puzzle_signal_listeners", "_on_deactivate_signal", emitter_id)

func _set_colour(new_colour):
	button_colour = new_colour
	$ButtonSpr.modulate = button_colour

func _set_button_type(new_type):
	use_mels_button = new_type
	if use_mels_button:
		base_texture_x = 64
	else:
		base_texture_x = 0
	self.button_pressed = button_pressed

func _set_button_pressed(new_state):
	button_pressed = new_state
	if button_pressed:
		$ButtonSpr.texture.region.position.x = base_texture_x + 32
	else:
		$ButtonSpr.texture.region.position.x = base_texture_x
