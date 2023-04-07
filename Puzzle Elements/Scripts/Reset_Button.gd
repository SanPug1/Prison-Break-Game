extends Control

func _ready():
	pass

func _reset_all_resettables():
	get_tree().call_group("resettable", "reset_position")
