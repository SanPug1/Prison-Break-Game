extends Node

signal next_puzzle
var bothbuttons = 0

func _ready():
	$Button1.show()
	$Button2.show()
	$keyArea/key.show()
	$keyArea/keygone.hide()
	$doorArea.hide()
	$doorArea.set_collision_layer_bit(0, false)
	$doorArea.set_collision_mask_bit(0, false)
	$Gate.show()
	$Gate.set_collision_layer_bit(0,true)
	$Gate.set_collision_mask_bit(0,true)

#func _process(delta):
#	pass


func _on_Button1_body_entered(body: Node) -> void:
	bothbuttons += 1
	$Button1.hide()
	print(bothbuttons)
	if bothbuttons == 2:
		$Gate.hide()
		$Gate.set_collision_layer_bit(0,false)
		$Gate.set_collision_mask_bit(0,false)

func _on_Button2_body_entered(body: Node) -> void:
	bothbuttons += 1
	$Button2.hide()
	$CanvasModulate.hide()
	$Player/Light2D.hide()
	
func _on_Button1_body_exited(body: Node) -> void:
	$Button1.show()
	$Gate.show()
	$Gate.set_collision_layer_bit(0,true)
	$Gate.set_collision_mask_bit(0,true)
	bothbuttons -= 1

func _on_Button2_body_exited(body: Node) -> void:
	$Button2.show()
	$CanvasModulate.show()
	$Player/Light2D.show()
	bothbuttons -= 1

func _on_keyArea_body_entered(body: Node) -> void:
	$keyArea/key.hide()
	$keyArea/keygone.show()
	$doorArea.show()
	$doorArea.set_collision_layer_bit(0, true)
	$doorArea.set_collision_mask_bit(0, true)

func _on_doorArea_body_entered(body: Node) -> void:
	emit_signal("next_puzzle")

func _on_ResetLevelButton_pressed() -> void:
	$Platform/AnimationPlayer.stop()
	$Platform/AnimationPlayer.play("movement")
	$Platform.position = get_node("platformspawn").position
	$box.position = get_node("spawn").position
	$box2.position = get_node("spawn2").position
	$Player.position = get_node("playerspawn").position
	$ResetLevelButton.release_focus()
	
