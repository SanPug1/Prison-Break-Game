extends Node

export(Array, PackedScene) var levels_in_order
signal credits
var current_level_index = 0
var current_level = null

export(bool) var start_immediately = true

func _ready():
	current_level_index = -1
	if start_immediately:
		start_playing()

func start_playing():
	$Music.play()
	current_level_index = 0
	load_level(0)

func load_next_level():
	current_level_index += 1
	load_level(current_level_index)

func load_level(level):
	if level >= len(levels_in_order) or level < 0:
		emit_signal("credits")
		return
	if current_level != null:
		current_level.queue_free()
	current_level = levels_in_order[level].instance()
	$Level.add_child(current_level)

func _on_music_finished():
	$Music.play()
