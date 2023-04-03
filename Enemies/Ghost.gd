extends KinematicBody2D


var lifetime := 10.0


func _process(delta: float) -> void:
	lifetime -= delta
	if lifetime > 0:
		move_and_slide(Vector2(0, -50))
	else:
		queue_free()
