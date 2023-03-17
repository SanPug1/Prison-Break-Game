extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap3.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if $UnpressedButtonTile.collided() == true:
#		$UnpressedButtonTile.hide()
#		$PressedButtonTile.show()
#		$ButtonTimer.start()
#		$TileMap.hide()
#		$TileMap3.show()
	pass


func _on_ButtonTimer_timeout() -> void:
	$TileMap3.hide()
	$TileMap.show()
	$PressedButtonTile.hide()
	$UnpressedButtonTile.show()


