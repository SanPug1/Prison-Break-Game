extends Node
signal next_puzzle

var firstrun = true

func _ready():
	$TileMap.show()


func _process(delta):
	if firstrun == true:
		$TileMap.show()
		$TileMap2.show()
		$Area2D.show()
		$PressedButtonTile.hide()
		$TileMap.set_collision_layer_bit(0, true)
		$TileMap.set_collision_mask_bit(0, true)
		$doorArea.hide()
		$doorArea.set_collision_layer_bit(0, false)
		$doorArea.set_collision_mask_bit(0, false)
		firstrun = false

func _on_ButtonTimer_timeout() -> void:
	$TileMap2.show()
	$PressedButtonTile.hide()
	$Area2D.show()
	$TileMap.set_collision_layer_bit(0, true)
	$TileMap.set_collision_mask_bit(0, true)
	

func _on_Area2D_body_entered(body: Node) -> void:
	$Area2D.hide()
	$PressedButtonTile.show()
	$doorArea.show()
	$doorArea.set_collision_layer_bit(0, true)
	$doorArea.set_collision_mask_bit(0, true)
	$TileMap2.hide()
	$TileMap2.set_collision_layer_bit(0, false)
	$TileMap2.set_collision_mask_bit(0, false)
	
func _on_Area2D_body_exited(body: Node) -> void:
	$ButtonTimer.start()
	$doorArea.hide()
	$TileMap2.show()
	$TileMap2.set_collision_layer_bit(0, true)
	$TileMap2.set_collision_mask_bit(0, true)



func _on_doorArea_body_entered(body: Node) -> void:
	emit_signal("next_puzzle")



func _on_ResetLevelButton_pressed() -> void:
	$box.position = get_node("spawn").position
	#$box2.position = get_node("spawn2").position
	#$box3.position = get_node("spawn3").position
	$ResetLevelButton.release_focus()
