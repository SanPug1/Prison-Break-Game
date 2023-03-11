extends RigidBody2D
 
export(float) var player_speed = 15
export(float,0,1) var horizontal_drag=0.93

var in_air = true
var moved_this_frame = false

func _ready():
	pass

func _process(delta):
	var controlledForce = Vector2.ZERO
	moved_this_frame = false
	if Input.is_action_pressed("player_left"):
		controlledForce.x -= player_speed
		moved_this_frame = true
	if Input.is_action_pressed("player_right"):
		controlledForce.x += player_speed
		moved_this_frame = true
	apply_central_impulse(controlledForce)

func _integrate_forces(state):
	if (!moved_this_frame):
		linear_velocity.x *= horizontal_drag
