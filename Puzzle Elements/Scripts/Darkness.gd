tool
extends Node

# warning-ignore-all:export_hint_type_mistmatch

class_name Darkness

export(int) var listener_id = 0
export(bool) var invert_behaviour = false setget _change_behaviour

var power_level = 0

export(float) var delay_activate = 0 setget _on_set_activate_delay
export(float) var delay_deactivate = 0 setget _on_set_deactivate_delay

export(float, 0, 1) var darkness_level = 1.0 setget _set_darkness_level

var queued_state = false

func _ready():
	$CanvasModulate.visible = invert_behaviour

func _on_set_activate_delay(new_delay):
	delay_activate = max(0, new_delay)

func _on_set_deactivate_delay(new_delay):
	delay_deactivate = max(0, new_delay)

func _on_activate_signal(source_id):
	if listener_id == source_id:
		if delay_activate == 0:
			$CanvasModulate.visible = !invert_behaviour
		elif queued_state == invert_behaviour and $DelayTimer.time_left > 0:
			$DelayTimer.stop()
		else:
			queued_state = !invert_behaviour
			$DelayTimer.wait_time = delay_activate
			$DelayTimer.start()

func _on_deactivate_signal(source_id):
	if listener_id == source_id:
		if delay_deactivate == 0:
			$CanvasModulate.visible = invert_behaviour
		elif queued_state != invert_behaviour and $DelayTimer.time_left > 0:
			$DelayTimer.stop()
		else:
			queued_state = invert_behaviour
			$DelayTimer.wait_time = delay_deactivate
			$DelayTimer.start()

func _change_behaviour(new_behaviour):
	invert_behaviour = new_behaviour
	$CanvasModulate.visible = invert_behaviour

func _after_delay():
	$CanvasModulate.visible = queued_state

func _set_darkness_level(new_level):
	darkness_level = new_level
	var inv = 1 - darkness_level
	$CanvasModulate.color.r = inv
	$CanvasModulate.color.g = inv
	$CanvasModulate.color.b = inv
