tool
extends Node2D

class_name MovingPlatform

export(int) var platform_width = 4 setget _platform_width_change
export(int) var platform_height = 2 setget _platform_height_change

export(NodePath) var track_start_node_path
export(NodePath) var track_end_node_path

onready var track_start
onready var track_end

# Duration of travel in one direction, in seconds
export(float) var track_duration : float = 5

func _ready():
	if not Engine.editor_hint:
		redraw_platform()
		track_start = get_node_or_null(track_start_node_path)
		track_end = get_node_or_null(track_end_node_path)
		if track_start != null and track_end != null:
			track_start = track_start.position
			track_end = track_end.position
			set_path_points()
			_on_move_back_done()

func _platform_width_change(new_width):
	platform_width = max(new_width, 1)
	if Engine.editor_hint:
		redraw_platform()

func _platform_height_change(new_height):
	platform_height = max(new_height, 1)
	if Engine.editor_hint:
		redraw_platform()

func set_path_points():
	$PathLine.clear_points()
	$PathLine.add_point(track_start)
	$PathLine.add_point(track_end)

func redraw_platform():
	$Platform/PlatformSpr.clear()
	for y in platform_height:
		for x in platform_width:
			$Platform/PlatformSpr.set_cell(x, y, 0)
	$Platform/PlatformSpr.update_bitmask_region()
	$Platform/PlatformSpr.position = -16 * Vector2(platform_width, platform_height)

func _on_move_forward_done():
	if track_start != null and track_end != null:
		$MoveBack.interpolate_property($Platform, "position", track_end, track_start, track_duration)
		$MoveBack.start()

func _on_move_back_done():
	if track_start != null and track_end != null:
		$MoveForward.interpolate_property($Platform, "position", track_start, track_end, track_duration)
		$MoveForward.start()
