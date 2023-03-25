extends KinematicBody2D
class_name MoveableBox

export var gravity = 200

var velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity.y += gravity
	velocity = move_and_slide(velocity)
	velocity = Vector2.ZERO
	
func slide(vector):
	velocity.x = vector.x
