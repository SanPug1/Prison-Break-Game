extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw() -> void:
	draw_circle_arc(get_viewport_rect().get_center(), 100, Color.red)

func draw_circle_arc(center, radius, color):
	var points = 64
	var previousLoc = Vector2.ZERO
	var loc = Vector2.ZERO
	var angle = 2*PI/points
	var oldA = 0
	var newA = angle


	for i in range(points):
		previousLoc.x = cos(oldA)*radius
		previousLoc.y = sin(oldA)*radius
		loc.x = cos(newA)*radius
		loc.y = sin(newA)*radius
		oldA += angle
		newA += angle
		print(previousLoc)
		print(loc)
		draw_line(previousLoc+center, loc+center, Color.red)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
