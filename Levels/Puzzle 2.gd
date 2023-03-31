extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var inQueue = []
var gate1Open = false
var gate2Open = false
var gate3Open = false
var gate4Open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	inQueue.resize(2)
	inQueue.fill(null)
	$Gate1.show()
	$Gate1.set_collision_layer_bit(0, true)
	$Gate1.set_collision_mask_bit(0, true)
	$Gate2.show()
	$Gate2.set_collision_layer_bit(0, true)
	$Gate2.set_collision_mask_bit(0, true)
	show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inQueue[0] != 1 and inQueue[1] != 1:
		gate1Open = false
		$Gate1.show()
		$Gate1.set_collision_layer_bit(0, true)
		$Gate1.set_collision_mask_bit(0, true)
	if inQueue[0] != 2 and inQueue[1] != 2:
		gate2Open = false
		$Gate2.show()
		$Gate2.set_collision_layer_bit(0, true)
		$Gate2.set_collision_mask_bit(0, true)
	if inQueue[0] != 3 and inQueue[1] != 3:
		gate3Open = false
		$Gate3.show()
		$Gate3.set_collision_layer_bit(0, true)
		$Gate3.set_collision_mask_bit(0, true)
	if inQueue[0] != 4 and inQueue[1] != 4:
		gate4Open = false
		$Gate4.show()
		$Gate4.set_collision_layer_bit(0, true)
		$Gate4.set_collision_mask_bit(0, true)
	pass
	
	

func _on_piece1_body_entered(body):
	$Gate1.hide()
	$Gate1.set_collision_layer_bit(0, false)
	$Gate1.set_collision_mask_bit(0, false)
	if gate1Open == false:
		if inQueue[0] == null:
			inQueue[0] = 1
		elif inQueue[1] == null:
			inQueue[1] = 1
		else:
			inQueue[0] = inQueue[1]
			inQueue[1] = 1
		gate1Open = true
	pass # Replace with function body.


func _on_piece2_body_entered(body):
	$Gate2.hide()
	$Gate2.set_collision_layer_bit(0, false)
	$Gate2.set_collision_mask_bit(0, false)
	if gate2Open == false:
		if inQueue[0] == null:
			inQueue[0] = 2
		elif inQueue[1] == null:
			inQueue[1] = 2
		else:
			inQueue[0] = inQueue[1]
			inQueue[1] = 2
		gate2Open = true
	pass # Replace with function body.


func _on_piece3_body_entered(body):
	$Gate3.hide()
	$Gate3.set_collision_layer_bit(0, false)
	$Gate3.set_collision_mask_bit(0, false)
	if gate3Open == false:
		if inQueue[0] == null:
			inQueue[0] = 3
		elif inQueue[1] == null:
			inQueue[1] = 3
		else:
			inQueue[0] = inQueue[1]
			inQueue[1] = 3
		gate3Open = true
	pass # Replace with function body.


func _on_piece4_body_entered(body):
	$Gate4.hide()
	$Gate4.set_collision_layer_bit(0, false)
	$Gate4.set_collision_mask_bit(0, false)
	if gate4Open == false:
		if inQueue[0] == null:
			inQueue[0] = 4
		elif inQueue[1] == null:
			inQueue[1] = 4
		else:
			inQueue[0] = inQueue[1]
			inQueue[1] = 4
		gate4Open = true
	pass # Replace with function body.
