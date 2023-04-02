extends Node

var levels

func _ready():
	levels = $Levels
	remove_child($Levels)
	
func _on_Title_Screen_game_start() -> void:
	add_child(levels)
