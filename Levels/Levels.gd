extends Node

var Puzzle2

func _ready() -> void:
	Puzzle2 = $Puzzle_2
	remove_child($Puzzle_2)
	
func _on_Puzzle_10_next_puzzle() -> void:
	add_child(Puzzle2)
	remove_child($Puzzle_10)
