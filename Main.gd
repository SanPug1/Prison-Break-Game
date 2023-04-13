extends Node

var levels
var title
var Credits
var precredit

func _ready():
	title = $Title_Screen
	precredit = $escape
	Credits = $Credits
	levels = $Manager
	remove_child($escape)
	remove_child($Credits)
	remove_child($Manager)
	
func _on_Title_Screen_game_start() -> void:
	remove_child($Title_Screen)
	add_child(levels)
	$Manager.start_playing()


func _on_Manager_credits() -> void:
	remove_child($Manager)
	add_child(precredit)


func _on_escape_credits() -> void:
	remove_child($escape)
	add_child(Credits)
