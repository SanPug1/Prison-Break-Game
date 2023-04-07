extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$doorArea.hide()
	$doorArea.set_collision_layer_bit(0, false)
	$doorArea.set_collision_mask_bit(0, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
