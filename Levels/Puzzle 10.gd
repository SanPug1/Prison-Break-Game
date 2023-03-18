extends Node

var firstrun = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap.show()
	$TileMap3.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if firstrun == true:
		$TileMap.show()
		$TileMap3.hide()
		$Area2D.show()
		$PressedButtonTile.hide()
		firstrun = false

func _on_ButtonTimer_timeout() -> void:
	$TileMap3.hide()
	$TileMap.show()
	$PressedButtonTile.hide()
	$Area2D.show()

func _on_Area2D_body_entered(body: Node) -> void:
	$Area2D.hide()
	$PressedButtonTile.show()
	$TileMap.hide()
	$TileMap3.show()

func _on_Area2D_body_exited(body: Node) -> void:
	$ButtonTimer.start()
