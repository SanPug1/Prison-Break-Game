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

func _integrate_forces(_state):
	linear_velocity.x = prepared_motion_this_frame.x
	linear_velocity.y += prepared_motion_this_frame.y
	# Apply Motion Multipliers
	
	if (linear_velocity.x > 0):
		linear_velocity.x *= postitive_motion_multiplier.x
	else:
		linear_velocity.x *= negative_motion_multiplier.x
	
	if (linear_velocity.y > 0):
		linear_velocity.y *= postitive_motion_multiplier.y
	else:
		linear_velocity.y *= negative_motion_multiplier.y
	
	linear_velocity.x *= all_motion_multiplier.x
	linear_velocity.y *= all_motion_multiplier.y

func _on_Collision_Detected(body_rid, body, body_shape_index, local_shape_index):
	print("Collision Detected")
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
	print("Collision Down")
	can_jump = true

func _on_Up_Collide(body_rid, body, body_shape_index, local_shape_index):
	print("Collision Up")

func _on_Left_Collide(body_rid, body, body_shape_index, local_shape_index):
	print("Collision Left")
	negative_motion_multiplier.x = 0

func _on_Right_Collide(body_rid, body, body_shape_index, local_shape_index):
	print("Collision Right")
	postitive_motion_multiplier.x = 0

func _on_General_Collide(body_rid, body, body_shape_index, local_shape_index):
	print("Collision General")

func _on_Collision_Ended(body_rid, body, body_shape_index, local_shape_index):
	print("Collision Ended")
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
	print("Collision Down")
	can_jump = false

func _on_Up_Collide_End(body_rid, body, body_shape_index, local_shape_index):
	print("Collision Up")

func _on_Left_Collide_End(body_rid, body, body_shape_index, local_shape_index):
	print("Collision Left")
	negative_motion_multiplier.x = 1

func _on_Right_Collide_End(body_rid, body, body_shape_index, local_shape_index):
	print("Collision Right")
	postitive_motion_multiplier.x = 1

func _on_General_Collide_End(body_rid, body, body_shape_index, local_shape_index):
	print("Collision General")
	pass
