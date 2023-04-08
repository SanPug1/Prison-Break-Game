# warning-ignore-all:narrowing_conversion

tool
extends Node2D

class_name Gate

enum CardinalDirections {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

export(int) var listener_id = 0
export(CardinalDirections) var open_direction = CardinalDirections.UP setget _set_open_direction

var gate_power_level : int = 0

export(int) var gate_width = 1 setget _set_gate_width
export(int) var gate_height = 1 setget _set_gate_height

var gate_dims_tiles : Vector2 = Vector2.ONE
var gate_dims_pixels : Vector2 = Vector2.ONE * 64

export(bool) var use_colour = true setget _set_use_colour
export(Color) var colour = Color.red setget _set_colour

var open_dir_vec : Vector2 = Vector2.UP
var motion_limit_vec : Vector2 = Vector2.ZERO
var current_motion_vec : Vector2 = Vector2.ZERO

var redraw_sprite = false

# Tiles per second
export(float) var opening_rate : float = 2
export(float) var closing_rate : float = 10

func _ready():
	$GateCollision/GateColShape.shape = RectangleShape2D.new()
	redraw_sprite = true

func _init():
	pass

func _process(delta):
	if redraw_sprite:
		redraw_gate()
		redraw_indicator()
		update_collider_size()
		redraw_sprite = false
	if Engine.editor_hint:
		return
	if current_motion_vec != Vector2.ZERO:
		var effective_motion_vec = current_motion_vec * delta
		var nextPos = $GateMask/GateBars.position + effective_motion_vec
		nextPos.x = clamp(nextPos.x, min(0, motion_limit_vec.x), max(0, motion_limit_vec.x))
		nextPos.y = clamp(nextPos.y, min(0, motion_limit_vec.y), max(0, motion_limit_vec.y))
		if nextPos == $GateMask/GateBars.position:
			effective_motion_vec = Vector2.ZERO
			current_motion_vec = Vector2.ZERO
		$GateMask/GateBars.position = nextPos
		$GateCollision/GateColShape.position = nextPos * 0.25 + Vector2(0, gate_dims_pixels.y * 0.25) + 4 * open_dir_vec * Vector2.RIGHT
		$GateCollision/GateColShape.shape.extents = 0.25 * (gate_dims_pixels - nextPos.abs()) - Vector2(4 + 4*abs(open_dir_vec.y), 0)

func _set_open_direction(open_dir):
	#print("Setting opening direction...")
	match open_dir:
		CardinalDirections.UP:
			open_dir_vec = Vector2.UP
		CardinalDirections.DOWN:
			open_dir_vec = Vector2.DOWN
		CardinalDirections.LEFT:
			open_dir_vec = Vector2.LEFT
		CardinalDirections.RIGHT:
			open_dir_vec = Vector2.RIGHT
	motion_limit_vec = open_dir_vec * gate_dims_pixels
	open_direction = open_dir
	redraw_sprite = true

func open():
	if gate_power_level > 0:
		current_motion_vec = opening_rate * open_dir_vec * 64

func close():
	if gate_power_level <= 0:
		gate_power_level = 0
		current_motion_vec = -closing_rate * open_dir_vec * 64

func _on_activate_signal(source_id):
	if listener_id == source_id:
		gate_power_level += 1
		open()

func _on_deactivate_signal(source_id):
	if listener_id == source_id:
		gate_power_level -= 1
		close()

func _set_use_colour(new_use_colour: bool):
	#print("Setting using colour...")
	$GateMask/GateColourIndicator.visible = new_use_colour
	use_colour = new_use_colour

func _set_colour(new_colour: Color):
	#print("Setting colour...")
	$GateMask/GateColourIndicator.modulate = new_colour
	colour = new_colour

func _set_gate_width(new_width):
	gate_width = max(1, new_width)
	#print("Setting width to: " + str(gate_width))
	gate_dims_tiles.x = gate_width
	gate_dims_pixels.x = 64*gate_width
	motion_limit_vec = open_dir_vec * gate_dims_pixels
	redraw_sprite = true

func _set_gate_height(new_height):
	gate_height = max(1, new_height)
	#print("Setting height to: " + str(gate_height))
	gate_dims_tiles.y = gate_height
	gate_dims_pixels.y = 64*gate_height
	motion_limit_vec = open_dir_vec * gate_dims_pixels
	redraw_sprite = true

func redraw_indicator():
	$GateMask/GateColourIndicator.clear()
	var step_vec : Vector2 = -open_dir_vec.tangent()
	var internal_vec : Vector2 = gate_dims_tiles + gate_dims_tiles * (open_dir_vec - step_vec)
	internal_vec.x = max(internal_vec.x - 1, 0)
	internal_vec.y = max(internal_vec.y - 1, 0)
	var external_vec = internal_vec + open_dir_vec - step_vec
	var steps : int = 2 * abs(gate_dims_tiles.dot(step_vec));
	$GateMask/GateColourIndicator.set_cell(external_vec.x, external_vec.y, 1)
	external_vec += step_vec
	for i in steps:
		$GateMask/GateColourIndicator.set_cell(internal_vec.x,internal_vec.y,1)
		$GateMask/GateColourIndicator.set_cell(external_vec.x,external_vec.y,1)
		internal_vec += step_vec
		external_vec += step_vec
	$GateMask/GateColourIndicator.set_cell(external_vec.x, external_vec.y, 1)
	$GateMask/GateColourIndicator.update_bitmask_region()

func redraw_gate():
	#print("Drawing gate...")
	$GateMask/GateBars.clear()
	for y in range(0, gate_dims_tiles.y):
		for x in range(min(open_dir_vec.x, 0), gate_dims_tiles.x+max(open_dir_vec.x, 0)):
			$GateMask/GateBars.set_cell(x, y, 0)
	$GateMask/GateBars.update_bitmask_region()
	$GateMask.rect_position.x = -gate_dims_pixels.x * 0.5
	$GateMask.rect_size = gate_dims_pixels

func update_collider_size():
	#print("Updating collider...")
	var collider_h_radius = 16*(gate_dims_tiles.x) - 4 * abs(open_dir_vec.y) - 4
	var collider_v_radius = 16*gate_dims_tiles.y
	var col_top_left = Vector2(-collider_h_radius, 0)
	var col_bottom_right = Vector2(collider_h_radius, 2*collider_v_radius)
	$GateCollision/GateColShape.position = (col_top_left + col_bottom_right) * 0.5 + 4*Vector2(open_dir_vec.x, 0)
	$GateCollision/GateColShape.shape.extents = Vector2(collider_h_radius, collider_v_radius)
