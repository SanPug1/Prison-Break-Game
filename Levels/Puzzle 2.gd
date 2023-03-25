extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var inQueue = []

# Called when the node enters the scene tree for the first time.
func _ready():
	inQueue.resize(2)
	inQueue.fill(null)
	show()
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
