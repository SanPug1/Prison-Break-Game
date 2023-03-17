extends Node

func _ready():
	$Player.lock = true
	$Player.visible = false

func _on_Game_Start():
	$Player.lock = false
	$Player.visible = true
