extends Area2D



func _on_Chest_body_entered(body: Node) -> void:
	G.take_chest(position)
	$AnimationPlayer.play("take")
