extends Area2D


var speed := 300.0
var vel := Vector2.ZERO
var lifetime := 2.0


func _process(delta):
	lifetime -= delta
	if lifetime <= 0:
		queue_free()
	
	global_position += vel * delta


func _on_Shot_body_entered(body):
	body.hit(1)
	queue_free()
