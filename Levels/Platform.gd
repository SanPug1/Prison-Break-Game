extends Node2D



func _ready() -> void:
	$AnimationPlayer.play("movement")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	$AnimationPlayer.play("movement")
