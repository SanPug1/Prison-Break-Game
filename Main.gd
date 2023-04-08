extends Node

var levels
var title
var Credits

func _ready():
	levels = $Manager
	title = $Title_Screen
	Credits = $Credits
	remove_child($Credits)
	remove_child($Manager)
	
func _on_Title_Screen_game_start() -> void:
	add_child(levels)
	remove_child($Title_Screen)
