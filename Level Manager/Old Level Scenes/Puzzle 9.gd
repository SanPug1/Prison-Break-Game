extends Node2D

signal next_puzzle

var bothbuttonspressed = 0
var playerhaskey = false

func _ready() -> void:
	$Button1.show()
	$Button2.show()
	$keyArea/key.show()
	$keyArea/keygone.hide()
	$Bars1.set_collision_layer_bit(0, true)
	$Bars1.set_collision_mask_bit(0, true)
	$Bars2.set_collision_layer_bit(0, true)
	$Bars2.set_collision_mask_bit(0, true)
	$door.set_collision_layer_bit(0, false)
	$door.set_collision_mask_bit(0, false)
	$door.hide()
#func _process(delta: float) -> void:
#	pass

func _on_Button1_body_entered(body: Node) -> void:
	bothbuttonspressed += 1
	print(bothbuttonspressed)
	$Button1.hide()
	if bothbuttonspressed == 2:
		$Bars1.set_collision_layer_bit(0, false)
		$Bars1.set_collision_mask_bit(0, false)
		$Bars1.hide()

func _on_Button2_body_entered(body: Node) -> void:
	bothbuttonspressed += 1
	$Bars2.set_collision_layer_bit(0, false)
	$Bars2.set_collision_mask_bit(0, false)
	$Bars2.hide()
	$Button2.hide()

func _on_Button1_body_exited(body: Node) -> void:
	$Bars1.set_collision_layer_bit(0, true)
	$Bars1.set_collision_mask_bit(0, true)
	$Bars1.show()
	$Button1.show()
	bothbuttonspressed -= 1

func _on_Button2_body_exited(body: Node) -> void:
	$Bars2.set_collision_layer_bit(0, true)
	$Bars2.set_collision_mask_bit(0, true)
	$Bars2.show()
	$Button2.show()
	bothbuttonspressed -= 1

func _on_keyArea_body_entered(body: Node) -> void:
	$keyArea/key.hide()
	$keyArea/keygone.show()
	$door.set_collision_layer_bit(0, true)
	$door.set_collision_mask_bit(0, true)
	$door.show()

func _on_door_body_entered(body: Node) -> void:
	emit_signal("next_puzzle")
	playerhaskey = false


func _on_ResetLevelButton_pressed() -> void:
	$Platform/AnimationPlayer.stop()
	$Platform/AnimationPlayer.play("movement")
	$Platform.position = get_node("platformspawn").position
	$box.position = get_node("spawn").position
	$box2.position = get_node("spawn2").position
	$Player.position = get_node("playerspawn").position
	$ResetLevelButton.release_focus()


