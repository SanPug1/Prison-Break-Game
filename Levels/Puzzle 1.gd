extends Node2D

signal level2
# Declare member variables here. Examples:
var itemFound = 0
var p1 = false
var p2 = false
var p3 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(itemFound == 3):
		emit_signal("level2")
	if Input.is_action_just_pressed("left_click"):
		if(get_viewport().get_mouse_position().x >= 278 && get_viewport().get_mouse_position().x <= 522 && get_viewport().get_mouse_position().y >= 398 && get_viewport().get_mouse_position().y <= 428):
			if(!p1):
				itemFound += 1
				p1 = true
				print(itemFound)
				draw_circle_arc($Polygon1.position, 125, Color.red)
		elif(get_viewport().get_mouse_position().x >= 397 && get_viewport().get_mouse_position().x <= 525 && get_viewport().get_mouse_position().y >= -38 && get_viewport().get_mouse_position().y <= 146):
			if(!p2):
				itemFound += 1
				p2 = true
				print(itemFound)
				#_draw($Polygon2.position, 185, 0, 2*PI)
		elif(get_viewport().get_mouse_position().x >= 827 && get_viewport().get_mouse_position().x <= 1027 && get_viewport().get_mouse_position().y >= 402 && get_viewport().get_mouse_position().y <= 602):
			if(!p3):
				itemFound += 1
				p3 = true
				print(itemFound)
				#_draw($Polygon3.position, 202, 0, 2*PI)
	
	
func draw_circle_arc(center, radius, color):
	var points = 32
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
