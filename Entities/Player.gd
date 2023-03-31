extends KinematicBody2D

# warning-ignore-all:unused_argument
# warning-ignore-all:export_hint_type_mistmatch

# Gravity Variables
export(Vector2) var gravity = Vector2.DOWN
export(float) var gravityStrength = 15

# Speed Variables
export(float) var jumpStrengthFactor = 42
export(float) var horizontalWalkSpeed = 150

# Maximum Speed Variables (-1 is disabled, kept for potential future movement constraints)
export(float) var maxVelocityMagnitude = -1
export(Vector2) var directionalVelocityLimit = Vector2(400, -1)

# Physics stuff...
var velocity = Vector2.ZERO
var queuedAccel = Vector2.ZERO

# Velocity Overrides:
var zeroBeforeAccel = {
	"up": false,
	"down": false,
	"left": false,
	"right": false
}
var zeroAfterAccel = {
	"up": false,
	"down": false,
	"left": false,
	"right": false
}

# Useful attributes
enum Directions {
	ALL,
	VERTICAL,
	HORIZONTAL,
	LEFT,
	RIGHT,
	UP,
	DOWN
}

# Action flags - controls when actions are possible
var onGround = false
var jumping = false
var canJump = false
var coyote_base_amt = 0.08
var coyote = 0
var lock = false

func _ready():
	pass

func _process(_delta):
	if lock:
		return
	queuedAccel = Vector2.ZERO
	queue_for_zero(Directions.HORIZONTAL, zeroBeforeAccel)
	if Input.is_action_pressed("player_left"):
		queuedAccel.x -= horizontalWalkSpeed
		unqueue_for_zero(Directions.HORIZONTAL, zeroBeforeAccel)
	if Input.is_action_pressed("player_right"):
		queuedAccel.x += horizontalWalkSpeed
		unqueue_for_zero(Directions.HORIZONTAL, zeroBeforeAccel)
	if jumping and !Input.is_action_pressed("player_jump"):
		queue_for_zero(Directions.UP, zeroAfterAccel)
	if canJump and Input.is_action_pressed("player_jump"):
		queuedAccel.y = -jumpStrengthFactor * gravityStrength
		queue_for_zero(Directions.DOWN, zeroBeforeAccel)
		jumping = true
	if (queuedAccel.x != 0):
		$Anims.animation = "walking"
		$Anims.playing = true
	if (queuedAccel.x < 0):
		$Anims.flip_h = false
	elif (queuedAccel.x > 0):
		$Anims.flip_h = true
	else:
		$Anims.animation = "default"
		$Anims.playing = false

func _physics_process(delta):
	if lock:
		return
	apply_zero_dict(zeroBeforeAccel)
	velocity += gravity * gravityStrength
	velocity += queuedAccel
	apply_zero_dict(zeroAfterAccel)
	if (directionalVelocityLimit.x > 0):
		velocity.x = clamp(velocity.x, -directionalVelocityLimit.x, directionalVelocityLimit.x)
	if (directionalVelocityLimit.y > 0):
		velocity.y = clamp(velocity.y, -directionalVelocityLimit.y, directionalVelocityLimit.y)
	if (maxVelocityMagnitude > 0):
		velocity = velocity.limit_length(maxVelocityMagnitude)
	var newVel = move_and_slide(velocity, Vector2.UP)
	# TODO: add a tolerance term to ground detection (if slopes)
	onGround = (newVel.y < velocity.y)
	if onGround:
		jumping = false
		coyote = coyote_base_amt
		canJump = true
	elif canJump:
		coyote -= delta
		if coyote < 0:
			canJump = false
		elif velocity.y < 0:
			canJump = false
	velocity = newVel
	reset_zero_dict(zeroBeforeAccel)
	reset_zero_dict(zeroAfterAccel)
	# probably redundant with the zeroing at the beginning of _process, but don't want to take chances
	queuedAccel = Vector2.ZERO
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is MoveableBox:
			collision.collider.slide(-collision.normal * (horizontalWalkSpeed/2))

func unqueue_for_zero(dir, dict):
	set_dir_flags(dir, dict, false)

func queue_for_zero(dir, dict):
	set_dir_flags(dir, dict, true)

func set_dir_flags(dir, dict, value):
	match(dir):
		Directions.ALL:
			dict.left = value
			dict.right = value
			dict.up = value
			dict.down = value
		Directions.VERTICAL:
			dict.up = value
			dict.down = value
		Directions.HORIZONTAL:
			dict.right = value
			dict.left = value
		Directions.LEFT:
			dict.left = value
		Directions.RIGHT:
			dict.right = value
		Directions.UP:
			dict.up = value
		Directions.DOWN:
			dict.down = value
		_:
			pass # Do nothing on non-valid value

func reset_zero_dict(dict):
	dict.left = false
	dict.right = false
	dict.up = false
	dict.down = false

func apply_zero_dict(dict):
	var topLeft = -Vector2.INF
	var bottomRight = Vector2.INF
	if dict.left:
		topLeft.x = 0
	if dict.right:
		bottomRight.x = 0
	if dict.up:
		topLeft.y = 0
	if dict.down:
		bottomRight.y = 0
	velocity.x = clamp(velocity.x, topLeft.x, bottomRight.x)
	velocity.y = clamp(velocity.y, topLeft.y, bottomRight.y)
