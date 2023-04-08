extends KinematicBody2D
class_name MoveableBox

export(Vector2) var gravity_vec = Vector2.DOWN
export(float) var gravity_strength : float = 15

var velocity = Vector2.ZERO
var snap = Vector2.DOWN * 16

var spawnpoint : Vector2 = Vector2.ZERO

func _ready():
	spawnpoint = position

func _physics_process(_delta):
	velocity += gravity_vec * gravity_strength
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	velocity.x = 0

func slide(vector):
	velocity.x = vector.x

func reset_position():
	position = spawnpoint
	velocity = Vector2.ZERO
