extends Node

var pressedbutton = false

func _ready():
	$IntroGameMusic.play()

func _on_IntroGameMusic_finished():
	if pressedbutton == false:
		$IntroGameMusic.play()

func _on_StartButton_button_up():
	$MessageLabel.hide()
	$StartButton.hide()
	$ColorRect.hide()
	$IntroGameMusic.stop()
	pressedbutton = true

