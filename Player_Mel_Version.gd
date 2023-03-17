extends KinematicBody2D

export var speed: = Vector2(300.0,1000.0)
export var gravity: = 3000.0

var velocity: = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = max(velocity.y, speed.y)
	velocity = move_and_slide(velocity)
	
