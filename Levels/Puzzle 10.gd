extends Node

var firstrun = true
var playerhaskey = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap.show()
	$TileMap3.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if firstrun == true:
		$TileMap.show()
		$TileMap3.hide()
		$keyArea.hide()
		$Area2D.show()
		$PressedButtonTile.hide()
		$TileMap.set_collision_layer_bit(0, true)
		$TileMap.set_collision_mask_bit(0, true)
		$TileMap3.set_collision_layer_bit(0, false)
		$TileMap3.set_collision_mask_bit(0, false)
		$doorArea.hide()
		firstrun = false

func _on_ButtonTimer_timeout() -> void:
	$TileMap3.hide()
	$keyArea.hide()
	$TileMap.show()
	$PressedButtonTile.hide()
	$Area2D.show()
	$TileMap.set_collision_layer_bit(0, true)
	$TileMap.set_collision_mask_bit(0, true)
	$TileMap3.set_collision_layer_bit(0, false)
	$TileMap3.set_collision_mask_bit(0, false)

func _on_Area2D_body_entered(body: Node) -> void:
	$Area2D.hide()
	$PressedButtonTile.show()
	$TileMap.hide()
	$TileMap3.show()
	$keyArea.show()
	$TileMap3.set_collision_layer_bit(0, true)
	$TileMap3.set_collision_mask_bit(0, true)
	$TileMap.set_collision_layer_bit(0, false)
	$TileMap.set_collision_mask_bit(0, false)
	
func _on_Area2D_body_exited(body: Node) -> void:
	$ButtonTimer.start()

func _on_keyArea_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	playerhaskey = true
	$doorArea.show()


func _on_doorArea_body_entered(body: Node) -> void:
	if playerhaskey == true and Input.is_action_just_released("interact"):
		get_tree().change_scene("res://Levels/Puzzle 1.tscn")
