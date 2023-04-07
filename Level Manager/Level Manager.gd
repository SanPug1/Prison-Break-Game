extends Node

export(Array, PackedScene) var levels_in_order

var current_level_index = 0
var current_level = null

func _ready():
	$Music.play()
	current_level_index = -1
	load_next_level()

func load_next_level():
	current_level_index += 1
	if current_level_index >= len(levels_in_order):
		return
	if current_level != null:
		current_level.queue_free()
	current_level = levels_in_order[current_level_index].instance()
	$Level.add_child(current_level)

func _on_music_finished():
	$Music.play()
