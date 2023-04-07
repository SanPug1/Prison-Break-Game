tool
extends Node

class_name Darkness

export(int) var listener_id = 0
export(bool) var invert_behaviour = false setget _change_behaviour

func _ready():
	pass

func _on_activate_signal(source_id):
	if listener_id == source_id:
		$CanvasModulate.visible = !invert_behaviour

func _on_deactivate_signal(source_id):
	if listener_id == source_id:
		$CanvasModulate.visible = invert_behaviour

func _change_behaviour(new_behaviour):
	invert_behaviour = new_behaviour
	$CanvasModulate.visible = invert_behaviour
