extends Node

var pressedbutton = false

func _ready():
	pass # Replace with function body.


func _on_StartButton_button_up():
	$MessageLabel.hide()
	$StartButton.hide()
	$ColorRect.hide()
	pressedbutton = true
	
