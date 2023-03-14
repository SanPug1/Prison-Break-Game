extends Area2D

export var speed = 200
export var jumpspeed = 300
var screen_size = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_d"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_a"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_w"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_s"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized()
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * speed * delta
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.flip_h = velocity.x > 0
		
