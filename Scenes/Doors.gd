extends Node2D



func _on_Area2D_body_entered(body: Node) -> void:
	if G.player.position.y < 40:
		G.new_room(3)
	elif G.player.position.y > 200:
		G.new_room(1)
	elif G.player.position.x < 40:
		G.new_room(2)
	else:
		G.new_room(0)
