extends RigidBody2D

var onthefloor = true
var screen_size = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	var velocity = Vector2.ZERO
	var verticalvelocity = get_linear_velocity().y
	
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_d"):
		velocity.x += 1
		set_linear_velocity(Vector2(200,verticalvelocity))
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_a"):
		velocity.x -= 1
		set_linear_velocity(Vector2(-200,verticalvelocity))
	else:
		set_linear_velocity(Vector2())
	
	if Input.is_action_just_pressed("ui_space"):
		apply_impulse(Vector2(),Vector2(0,-150))
		
	if velocity.length() > 0:
		velocity = velocity.normalized()
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position.x = clamp(position.x,15,screen_size.x-15)
	position.y = clamp(position.y,0,screen_size.y-55)

	if velocity.x != 0:
		$AnimatedSprite.animation = "walking"
		$AnimatedSprite.flip_h = velocity.x > 0

