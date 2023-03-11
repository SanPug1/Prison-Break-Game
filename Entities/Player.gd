extends RigidBody2D

export(float) var max_speed = 20.0
export(float) var h_acceleration = 15.0
export(float,0,1) var horizontal_drag=0.93

var in_air = true
var moved_this_frame = false

func _ready():
	pass

func _process(_delta):
	var controlledForce = Vector2.ZERO
	moved_this_frame = false
	if Input.is_action_pressed("player_left"):
		controlledForce.x -= h_acceleration
		moved_this_frame = true
	if Input.is_action_pressed("player_right"):
		controlledForce.x += h_acceleration
		moved_this_frame = true
	controlledForce.x = clamp(controlledForce.x, -max_speed, max_speed)
	apply_central_impulse(controlledForce)

func _integrate_forces(_state):
	if (!moved_this_frame):
		linear_velocity.x *= horizontal_drag
