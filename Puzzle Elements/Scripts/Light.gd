tool
extends Node2D

class_name Spotlight

# warning-ignore-all:narrowing_conversion

export(int) var listener_id = 0
var power_level = 0

export(float) var light_scale : int = 1 setget _set_light_scaling
export(Vector2) var light_dimensions = Vector2(1,1) setget _set_light_dimensions

export(float, 0, 2) var strength : float = 1 setget _change_strength

export(bool) var invert_behaviour = false setget _change_light_behaviour

func _ready():
	add_to_group("puzzle_signal_listeners")

func _set_light_scaling(new_light_scale):
	light_scale = max(0, new_light_scale)
	update_light_size()

func _set_light_dimensions(new_light_dims):
	light_dimensions.x = max(0, new_light_dims.x)
	light_dimensions.y = max(0, new_light_dims.y)
	update_light_size()

func update_light_size():
	self.scale = light_dimensions * light_scale * 0.25

func _on_activate_signal(sender_id):
	if sender_id == listener_id:
		power_level += 1
		if power_level >= 1:
			self.visible = !invert_behaviour

func _on_deactivate_signal(sender_id):
	if sender_id == listener_id:
		power_level -= 0
		if power_level <= 0:
			power_level = 0
			self.visible = invert_behaviour

func _change_light_behaviour(new_behaviour):
	invert_behaviour = new_behaviour
	self.visible = invert_behaviour

func _change_strength(new_strength):
	strength = new_strength
	self.energy = strength
