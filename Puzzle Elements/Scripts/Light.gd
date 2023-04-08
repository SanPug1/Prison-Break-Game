tool
extends Node2D

class_name Spotlight

# warning-ignore-all:narrowing_conversion

export(int) var listener_id = 0
var power_level = 0

export(float) var light_scale : int = 1 setget _set_light_scaling
export(Vector2) var light_dimensions = Vector2(1,1) setget _set_light_dimensions

export(float) var delay_activate : float = 0 setget _on_set_activate_delay
export(float) var delay_deactivate : float = 0 setget _on_set_deactivate_delay

export(float, 0, 2) var strength : float = 1 setget _change_strength

export(bool) var invert_behaviour = false setget _change_light_behaviour

var queued_state = false

func _ready():
	update_light_size()

func _set_light_scaling(new_light_scale):
	light_scale = max(0, new_light_scale)
	if Engine.editor_hint:
		update_light_size()

func _set_light_dimensions(new_light_dims):
	light_dimensions.x = max(0, new_light_dims.x)
	light_dimensions.y = max(0, new_light_dims.y)
	if Engine.editor_hint:
		update_light_size()

func update_light_size():
	if $Illuminate != null:
		$Illuminate.scale = light_dimensions * light_scale * 0.25

func _on_activate_signal(sender_id):
	if sender_id == listener_id:
		#print("Recieved Activation Signal")
		power_level += 1
		if power_level >= 1:
			if delay_activate == 0:
				#print("Set visible to " + str(!invert_behaviour))
				$Illuminate.visible = !invert_behaviour
			elif queued_state == invert_behaviour and $DelayTimer.time_left > 0:
				#print("Cancelled timer")
				$DelayTimer.stop()
			else:
				#print("Queued visible to be " + str(!invert_behaviour))
				queued_state = !invert_behaviour
				$DelayTimer.wait_time = delay_activate
				$DelayTimer.start()

func _on_deactivate_signal(sender_id):
	if sender_id == listener_id:
		#print("Recieved Deactivation Signal.")
		power_level -= 1
		if power_level <= 0:
			power_level = 0
			if delay_deactivate == 0:
				#print("Set visible to " + str(invert_behaviour))
				$Illuminate.visible = invert_behaviour
			elif queued_state != invert_behaviour and $DelayTimer.time_left > 0:
				#print("Cancelled timer")
				$DelayTimer.stop()
			else:
				#print("Queued visible to be " + str(invert_behaviour))
				queued_state = invert_behaviour
				$DelayTimer.wait_time = delay_deactivate
				$DelayTimer.start()

func _change_light_behaviour(new_behaviour):
	invert_behaviour = new_behaviour
	$Illuminate.visible = invert_behaviour

func _change_strength(new_strength):
	strength = new_strength
	$Illuminate.energy = strength

func _after_timer_delay():
	#print("Timer elapsed. Visible set to: " + str(queued_state))
	$Illuminate.visible = queued_state

func _on_set_activate_delay(new_delay):
	delay_activate = max(0, new_delay)

func _on_set_deactivate_delay(new_delay):
	delay_deactivate = max(0, new_delay)
