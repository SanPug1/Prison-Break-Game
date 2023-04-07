extends Area2D

class_name Door

func _ready():
	pass

func _on_Door_body_entered(_body):
	get_tree().call_group("level_manager", "load_next_level")
