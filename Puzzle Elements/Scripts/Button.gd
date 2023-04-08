tool
extends Area2D

class_name FloorButton

export var button_colour : Color = Color.red setget _set_colour
export var emitter_id : int = 0
export var use_mels_button : bool = false setget _set_button_type

export var turn_off_delay : float = 0

var objects_on_button = 0 setget _set_button_pressed

var base_texture_x : int = 0

func _ready():
	$ButtonSpr.modulate = button_colour

func _on_button_pressed(_body: Node) -> void:
	self.objects_on_button += 1
	if objects_on_button == 1:
		get_tree().call_group("puzzle_signal_listeners", "_on_activate_signal", emitter_id)

func _on_button_released(_body: Node) -> void:
	if turn_off_delay <= 0:
		send_released_signal()
	else:
		$Timer.wait_time = turn_off_delay
		$Timer.start()

func send_released_signal():
	self.objects_on_button -= 1
	if objects_on_button == 0:
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
	self.objects_on_button = objects_on_button

func _set_button_pressed(new_state):
	objects_on_button = new_state
	if objects_on_button > 0:
		$ButtonSpr.texture.region.position.x = base_texture_x + 32
	else:
		objects_on_button = 0
		$ButtonSpr.texture.region.position.x = base_texture_x
