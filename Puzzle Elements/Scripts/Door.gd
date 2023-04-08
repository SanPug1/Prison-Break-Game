tool
extends Area2D

class_name Door

export(bool) var enabled = true setget _set_enabled

func _ready():
	pass

func _on_Door_body_entered(_body):
	print("Level Complete!")
	get_tree().call_group("level_manager", "load_next_level")

func _set_enabled(newval):
	enabled = newval
	$DoorCollide.set_deferred("disabled", !enabled)
	if enabled:
		$DoorSpr.texture.region.position.x = 0
	else:
		$DoorSpr.texture.region.position.x = 32

func activate():
	self.enabled = true
