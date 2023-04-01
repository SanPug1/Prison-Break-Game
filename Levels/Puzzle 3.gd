extends Node

signal next_puzzle

var firstrun = true
var playerhaskey = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if firstrun == true:
		$TileMap.show()
		$Area2D.show()
		$PressedButtonTile.hide()
		$TileMap.set_collision_layer_bit(0, true)
		$TileMap.set_collision_mask_bit(0, true)
		$doorArea.hide()
		$doorArea.set_collision_layer_bit(0, false)
		$doorArea.set_collision_mask_bit(0, false)
		firstrun = false

func _on_ButtonTimer_timeout() -> void:
	$TileMap.show()
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
	
func _on_Area2D_body_exited(body: Node) -> void:
	$ButtonTimer.start()
	$doorArea.hide()



func _on_doorArea_body_entered(body: Node) -> void:
	emit_signal("next_puzzle")
	playerhaskey = false
