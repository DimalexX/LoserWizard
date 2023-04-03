extends Node2D


func _process(delta: float) -> void:
	if G.cursed:
		if global_position.distance_to(G.player.global_position) < 20:
			kill() #нападение озверевшего дерева


func kill():
	if G.player.global_position.x > global_position.x:
		$AnimationPlayer.play("right")
	else:
		$AnimationPlayer.play("left")
	set_process(false)
	G.player.death()
