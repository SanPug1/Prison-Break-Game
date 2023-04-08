tool
extends Node2D

class_name Key

export(float) var chain_length = 0.0 setget _set_chain_length

func _ready():
	pass

func _set_chain_length(new_length):
	chain_length = max(0, new_length)
	$Chain.position.y = -chain_length * 32
	$Chain.region_rect.position.y = -chain_length * 32
	$Chain.region_rect.size.y = chain_length * 32

func _on_key_pickup(_body):
	$KeySpr.texture.region.position.x = 32
	get_tree().call_group("doors", "activate")
	$PickupDetect/PickupZone.set_deferred("disabled", true)
