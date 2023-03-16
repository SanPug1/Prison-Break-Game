extends RigidBody2D

# warning-ignore-all:unused_argument

export(float) var horizontal_speed = 200.0
export(float) var jump_strength = 350.0

var can_jump = false
var prepared_motion_this_frame = Vector2.ZERO

var postitive_motion_multiplier = Vector2.ONE
var negative_motion_multiplier = Vector2.ONE
var all_motion_multiplier = Vector2.ONE

func _ready():
	pass

func _process(_delta):
	prepared_motion_this_frame = Vector2.ZERO
	if Input.is_action_pressed("player_left"):
		prepared_motion_this_frame.x -= horizontal_speed
	if Input.is_action_pressed("player_right"):
		prepared_motion_this_frame.x += horizontal_speed
	if can_jump and Input.is_action_pressed("player_jump"):
		prepared_motion_this_frame.y -= jump_strength
		can_jump = false
	
	# Apply Motion Multipliers
	if (prepared_motion_this_frame.x > 0):
		prepared_motion_this_frame.x *= postitive_motion_multiplier.x
	else:
		prepared_motion_this_frame.x *= negative_motion_multiplier.x
	if (prepared_motion_this_frame.y > 0):
		prepared_motion_this_frame.y *= postitive_motion_multiplier.y
	else:
		prepared_motion_this_frame.y *= negative_motion_multiplier.y
	prepared_motion_this_frame.x *= all_motion_multiplier.x
	prepared_motion_this_frame.y *= all_motion_multiplier.y

func _integrate_forces(_state):
	linear_velocity.x = prepared_motion_this_frame.x
	linear_velocity.y += prepared_motion_this_frame.y

func _on_Collision_Detected(body_rid, body, body_shape_index, local_shape_index):
	var collider = shape_owner_get_owner(local_shape_index)
	if collider == $Detect_Bottom:
		_on_Down_Collide(body_rid, body, body_shape_index, local_shape_index)
	elif collider == $Detect_Top:
		_on_Up_Collide(body_rid, body, body_shape_index, local_shape_index)
	elif collider == $Detect_Left:
		_on_Left_Collide(body_rid, body, body_shape_index, local_shape_index)
	elif collider == $Detect_Right:
		_on_Right_Collide(body_rid, body, body_shape_index, local_shape_index)
	else:
		_on_General_Collide(body_rid, body, body_shape_index, local_shape_index)

func _on_Down_Collide(body_rid, body, body_shape_index, local_shape_index):
	can_jump = true

func _on_Up_Collide(body_rid, body, body_shape_index, local_shape_index):
	pass

func _on_Left_Collide(body_rid, body, body_shape_index, local_shape_index):
	negative_motion_multiplier.x = 0

func _on_Right_Collide(body_rid, body, body_shape_index, local_shape_index):
	postitive_motion_multiplier.x = 0

func _on_General_Collide(body_rid, body, body_shape_index, local_shape_index):
	pass

func _on_Collision_Ended(body_rid, body, body_shape_index, local_shape_index):
	var collider = shape_owner_get_owner(local_shape_index)
	if collider == $Detect_Bottom:
		_on_Down_Collide_End(body_rid, body, body_shape_index, local_shape_index)
	elif collider == $Detect_Top:
		_on_Up_Collide_End(body_rid, body, body_shape_index, local_shape_index)
	elif collider == $Detect_Left:
		_on_Left_Collide_End(body_rid, body, body_shape_index, local_shape_index)
	elif collider == $Detect_Right:
		_on_Right_Collide_End(body_rid, body, body_shape_index, local_shape_index)
	else:
		_on_General_Collide_End(body_rid, body, body_shape_index, local_shape_index)

func _on_Down_Collide_End(body_rid, body, body_shape_index, local_shape_index):
	can_jump = false

func _on_Up_Collide_End(body_rid, body, body_shape_index, local_shape_index):
	pass

func _on_Left_Collide_End(body_rid, body, body_shape_index, local_shape_index):
	negative_motion_multiplier.x = 1

func _on_Right_Collide_End(body_rid, body, body_shape_index, local_shape_index):
	postitive_motion_multiplier.x = 1

func _on_General_Collide_End(body_rid, body, body_shape_index, local_shape_index):
	pass
