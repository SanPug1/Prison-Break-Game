extends Node

var levels
var title
var Credits

func _ready():
	title = $Title_Screen
	Credits = $Credits
	remove_child($Credits)
	
func _on_Title_Screen_game_start() -> void:
	remove_child($Title_Screen)
	$Manager.start_playing()
