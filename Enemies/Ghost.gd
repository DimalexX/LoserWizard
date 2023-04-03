extends KinematicBody2D


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	move_and_slide(Vector2(0, -50))
