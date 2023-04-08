tool
extends Node2D

class_name MovingPlatform

export(int) var platform_width = 4 setget _platform_width_change
export(int) var platform_height = 2 setget _platform_height_change

export(NodePath) var track_end_node

onready var track_start
onready var track_end

var motion_dir = true

# Duration of travel in one direction, in seconds
export(float) var track_duration : float = 5

func _ready():
	if not Engine.editor_hint:
		redraw_platform()
		track_end = get_node_or_null(track_end_node)
		if track_end != null:
			track_start = $Platform.position
			track_end = track_end.position
			set_path_points()
			_on_motion_done()

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

func _on_motion_done():
	if track_start != null and track_end != null:
		if motion_dir:
			$MovePlatform.interpolate_property($Platform, "position", track_start, track_end, track_duration)
		else:
			$MovePlatform.interpolate_property($Platform, "position", track_end, track_start, track_duration)
		$MovePlatform.start()
		motion_dir = !motion_dir

func reset_position():
	$MovePlatform.stop_all()
	motion_dir = true
	_on_motion_done()
