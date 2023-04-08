extends Node2D

signal next_puzzle
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Gate.show()
	$Gate.set_collision_layer_bit(0, true)
	$Gate.set_collision_mask_bit(0, true)
	$Button.show()
	$CanvasModulate.hide()
	$Player/Light2D.hide()
#func _process(delta: float) -> void:
#	pass

func _on_Button_body_entered(body: Node) -> void:
	$Button.hide()
	$Gate.hide()
	$Gate.set_collision_layer_bit(0, false)
	$Gate.set_collision_mask_bit(0, false)
	$CanvasModulate.show()
	$Player/Light2D.show()

func _on_Button_body_exited(body: Node) -> void:
	$ButtonTimer.start()

func _on_ButtonTimer_timeout() -> void:
	$Gate.show()
	$Gate.set_collision_layer_bit(0, true)
	$Gate.set_collision_mask_bit(0, true)
	$Button.show()
	$CanvasModulate.hide()
	$Player/Light2D.hide()

func _on_doorArea_body_entered(body: Node) -> void:
	emit_signal("next_puzzle")
