extends KinematicBody2D
#
#export var speed = 0.5
#var screen_size = get_viewport_rect().size
#var inbox = false
#
#func _process(delta: float) -> void:
#	var velocity = Vector2.ZERO
#
#	if collision == true:
#		inbox = true
#	else:
#		inbox = false
#
#	if inbox == true:
#		if Input.is_action_pressed("player_left"):
#			velocity.x -= 1
#		if Input.is_action_pressed("player_right"):
#			velocity.x += 1
#
#		position += velocity * speed * delta
#		position.x = clamp(position.x,0,screen_size.x)
#		position.y = clamp(position.y,0,screen_size.y)
