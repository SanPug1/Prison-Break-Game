tool
extends Node2D

class_name Switch

enum SwitchDirs {
	UP,
	RIGHT,
	DOWN,
	LEFT
}

export(int) var emitter_id = 0
export(Color) var switch_colour = Color.red setget _set_switch_colour

export(SwitchDirs) var facing = SwitchDirs.UP setget _change_switch_dir

var countdown = -1 setget _change_countdown

export(int) var max_others_on = 0 setget _set_max_toggled
export(bool) var infinite_others_on = true

var toggled = false

var can_be_toggled = true

func _ready():
	add_to_group("switches")
	self.countdown = max_others_on

func _set_max_toggled(new_max):
	max_others_on = max(new_max, 0)

func _change_switch_dir(newdir):
	facing = newdir
	$Inner.rotation_degrees = 90 * facing

func alter_total_switches(amt, switch):
	if switch == self or !toggled or infinite_others_on:
		return
	self.countdown += amt
	if countdown < 0:
		toggle(false)

func _change_countdown(newval):
	countdown = newval

func _set_switch_colour(new_colour):
	switch_colour = new_colour
	$Inner/SwitchSpr.modulate = new_colour

func _switch_toggled(_body):
	if can_be_toggled:
		toggle(true)
		can_be_toggled = false

func _switch_toggleable(_body):
	can_be_toggled = true

func toggle(flipped_by_player):
	toggled = !toggled
	var texture_x = 0
	var func_name = ""
	var switch_delta = 0
	if toggled:
		texture_x = 32
		func_name = "_on_activate_signal"
		self.countdown = max_others_on
		switch_delta = -1
	else:
		texture_x = 0
		func_name = "_on_deactivate_signal"
		switch_delta = 1
	$Inner/SwitchSpr.texture.region.position.x = texture_x
	get_tree().call_group("puzzle_signal_listeners", func_name, emitter_id)
	if flipped_by_player:
		get_tree().call_group("switches", "alter_total_switches", switch_delta, self)
