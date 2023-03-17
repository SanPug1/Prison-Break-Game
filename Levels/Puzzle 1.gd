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
		if(get_viewport().get_mouse_position().x >= 266 && get_viewport().get_mouse_position().x <= 510 && get_viewport().get_mouse_position().y >= 398 && get_viewport().get_mouse_position().y <= 428):
			if(!p1):
				itemFound += 1
				p1 = true
			#_draw($Polygon1.position, 125, 0, 2*PI)
		elif(get_viewport().get_mouse_position().x >= 385 && get_viewport().get_mouse_position().x <= 513 && get_viewport().get_mouse_position().y >= -38 && get_viewport().get_mouse_position().y <= 146):
			if(!p2):
				itemFound += 1
				p2 = true
			#_draw($Polygon2.position, 185, 0, 2*PI)
		elif(get_viewport().get_mouse_position().x >= 827 && get_viewport().get_mouse_position().x <= 1027 && get_viewport().get_mouse_position().y >= 402 && get_viewport().get_mouse_position().y <= 602):
			if(!p3):
				itemFound += 1
				p3 = true
			#_draw($Polygon3.position, 202, 0, 2*PI)
	#print(itemFound)

#func _draw(center, radius, angle_from, angle_to):
#	draw_circle_arc(center, radius, angle_from, angle_to, Color.red)
#
#func draw_circle_arc(center, radius, angle_from, angle_to, color):
#	var nb_points = 32
#	var points_arc = PackedVector2Array()
#
#	for i in range(nb_points + 1):
#		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
#		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
#
#	for index_point in range(nb_points):
#		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
