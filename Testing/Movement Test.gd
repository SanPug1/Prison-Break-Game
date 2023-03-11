extends Node2D

func _ready():
	pass

func _process(_delta):
	var mmP = $Player.postitive_motion_multiplier
	var mmN = $Player.negative_motion_multiplier
	var mmA = $Player.all_motion_multiplier
	$Info/Label.text = "Multipliers:"
	$Info/Label.text += "\n+x: " + str(mmP.x)
	$Info/Label.text += "\n+y: " + str(mmP.y)
	$Info/Label.text += "\n-x: " + str(mmN.x)
	$Info/Label.text += "\n-y: " + str(mmN.y)
	$Info/Label.text += "\nx: " + str(mmA.x)
	$Info/Label.text += "\ny: " + str(mmA.y)
