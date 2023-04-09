extends Node

var levels
var title
var Credits

func _ready():
	title = $Title_Screen
	Credits = $Credits
	levels = $Manager
	remove_child($Credits)
	remove_child($Manager)
	
func _on_Title_Screen_game_start() -> void:
	remove_child($Title_Screen)
	add_child(levels)
	$Manager.start_playing()


func _on_Manager_credits() -> void:
	remove_child($Manager)
	add_child(Credits)
