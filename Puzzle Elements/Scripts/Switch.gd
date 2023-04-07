tool
extends Node2D

class_name Switch

export(int) var emitter_id = 0
export(Color) var switch_colour = Color.red setget _set_switch_colour

var total_switches_on = 0

export(int) var max_others_on = 0 setget _set_max_toggled
export(bool) var infinite_others_on = true

var toggled = false

var can_be_toggled = true

func _ready():
	add_to_group("switches")

func _set_max_toggled(new_max):
	max_others_on = max(new_max, 0)

func alter_total_switches(amt):
	total_switches_on += amt
	if total_switches_on > max_others_on + 1 and toggled:
		toggle()

func _set_switch_colour(new_colour):
	switch_colour = new_colour
	$SwitchSpr.modulate = new_colour

func _switch_toggled(_body):
	if can_be_toggled:
		toggle()
		can_be_toggled = false

func _switch_toggleable(_body):
	can_be_toggled = true

func toggle():
	toggled = !toggled
	var texture_x = 0
	var func_name = ""
	var switch_delta = 0
	if toggled:
		texture_x = 32
		func_name = "_on_activate_signal"
		switch_delta = 1
	else:
		texture_x = 0
		func_name = "_on_deactivate_signal"
		switch_delta = -1
	$SwitchSpr.texture.region.position.x = texture_x
	get_tree().call_group("puzzle_signal_listeners", func_name, emitter_id)
	get_tree().call_group("switches", "alter_total_switches", switch_delta)
