extends Node2D


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if G.cursed:
		if global_position.distance_to(G.player.global_position) < 20:
			kill()


func kill():
	if G.player.global_position.x > global_position.x:
		$AnimationPlayer.play("right")
	else:
		$AnimationPlayer.play("left")
	set_process(false)
	G.player.death()
