extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$doorArea.hide()
	$doorArea.setcollision_layer_bit(0, false)
	$doorArea.setcollision_mask_bit(0, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
