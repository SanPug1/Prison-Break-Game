extends Node

var pressedbutton = false
var visiblebutton = true

func _ready():
	$IntroGameMusic.play()

func _on_IntroGameMusic_finished():
	if pressedbutton == false:
		$IntroGameMusic.play()

func _on_StartButton_button_up():
	$MessageLabel.hide()
	$GameNameLabel.hide()
	$StartButton.hide()
	$MainMenuBackground.hide()
	$IntroGameMusic.stop()
	$TextTimer.stop()
	pressedbutton = true



func _on_TextTimer_timeout():
	if visiblebutton == false and pressedbutton == false:
		visiblebutton = true
		$MessageLabel.show()
	elif visiblebutton == true and pressedbutton == false:
		visiblebutton = false
		$MessageLabel.hide()
	else:
		$MessageLabel.hide()
		
