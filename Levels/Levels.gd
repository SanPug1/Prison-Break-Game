extends Node

var Puzzle1
var Puzzle2
var Puzzle3
var Puzzle4
var Puzzle5
var Puzzle6
var Puzzle7
var Puzzle8
var Puzzle9
var Puzzle10
var currentlevel

func _ready() -> void:
	Puzzle1 = $Puzzle_1
	remove_child($Puzzle_1)
	Puzzle2 = $Puzzle_2
	remove_child($Puzzle_2)
	Puzzle3 = $Puzzle_3
	remove_child($Puzzle_3)
	Puzzle4 = $Puzzle_4
	remove_child($Puzzle_4)
	Puzzle5 = $Puzzle_5
	remove_child($Puzzle_5)
	Puzzle6 = $Puzzle_6
	remove_child($Puzzle_6)
	Puzzle7 = $Puzzle_7
	remove_child($Puzzle_7)
	Puzzle8 = $Puzzle_8
	remove_child($Puzzle_8)
	Puzzle9 = $Puzzle_9
	remove_child($Puzzle_9)
	Puzzle10 = $Puzzle_10
#	remove_child($Puzzle_10)
	currentlevel = Puzzle10
	$song.play()
	
func _on_Puzzle_10_next_puzzle() -> void:
	remove_child($Puzzle_10)
	add_child(Puzzle2)
	currentlevel = Puzzle2
func _on_Puzzle_2_next_puzzle() -> void:
	remove_child($Puzzle_2)
	add_child(Puzzle3)
	currentlevel = Puzzle3
func _on_Puzzle_3_next_puzzle() -> void:
	remove_child($Puzzle_3)
	add_child(Puzzle8)
	currentlevel = Puzzle8
func _on_Puzzle_8_next_puzzle() -> void:
	remove_child($Puzzle_8)
	add_child(Puzzle9)
	currentlevel = Puzzle9
func _on_Puzzle_9_next_puzzle() -> void:
	remove_child($Puzzle_9)
	add_child(Puzzle7)
	currentlevel = Puzzle7
func _on_Puzzle_7_next_puzzle() -> void:
	remove_child($Puzzle_7)
	add_child(Puzzle4)
	currentlevel = Puzzle4

func _on_song_finished() -> void:
	$song.play()
