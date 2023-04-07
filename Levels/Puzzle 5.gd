extends Node2D

signal next_puzzle
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	$rightButton/unpressed.show()
	$rightGate.show()
	$leftButton/unpressed.show()
	$leftGate.show()
	$exitButton/ColorRect.color = Color(1, 0, 0, 1)
	$exitGate.show()
	$ColorRect2.color = Color(1, 0, 0, 1)
	$ColorRect2.show()
	$door.show()
	$door.set_collision_layer_bit(0, false)
	$door.set_collision_mask_bit(0, false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rightButton_body_entered(body):
	$rightButton/unpressed.hide()
	$rightGate.hide()
	$rightGate.set_collision_layer_bit(0, false)
	$rightGate.set_collision_mask_bit(0, false)
	pass # Replace with function body.

func _on_rightButton_body_exited(body):
	$rightButton/unpressed.show()
	$rightGate.show()
	$rightGate.set_collision_layer_bit(0, true)
	$rightGate.set_collision_mask_bit(0, true)
	pass # Replace with function body.


func _on_leftButton_body_entered(body):
	$leftButton/unpressed.hide()
	$leftGate.hide()
	$leftGate.set_collision_layer_bit(0, false)
	$leftGate.set_collision_mask_bit(0, false)
	pass # Replace with function body.


func _on_leftButton_body_exited(body):
	$leftButton/unpressed.show()
	$leftGate.show()
	$leftGate.set_collision_layer_bit(0, true)
	$leftGate.set_collision_mask_bit(0, true)
	pass # Replace with function body.


func _on_exitButton_body_entered(body):
	$exitButton/ColorRect.color = Color(0, 1, 0, 1)
	$exitGate.hide()
	$ColorRect2.color = Color(0, 1, 0, 1)
	$exitGate.set_collision_layer_bit(0, false)
	$exitGate.set_collision_mask_bit(0, false)
	pass # Replace with function body.

func _on_key_body_entered(body):
	$door.set_collision_layer_bit(0, true)
	$door.set_collision_mask_bit(0 ,true)
	pass # Replace with function body.

func _on_door_body_entered(body):
	emit_signal("next_puzzle")
	pass # Replace with function body.
