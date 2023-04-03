extends KinematicBody2D


const J_TIMER = 4
const JT_DELTA = 1

onready var Ghost = preload("res://Enemies/Ghost.tscn")
onready var sprite := $AnimatedSprite

var jump_timer: float
var jumping: bool = false
var dir: Vector2 = Vector2.ZERO


func _ready() -> void:
	jump_timer = rand_range(J_TIMER-JT_DELTA, J_TIMER+JT_DELTA)


func _process(delta: float) -> void:
	if dir.length() > 0:
		move_and_slide(dir)
	
	if jumping: return
	
	jump_timer -= delta
	if jump_timer <= 0:
		jump_timer = rand_range(J_TIMER-JT_DELTA, J_TIMER+JT_DELTA)
		jump()


func jump():
	sprite.play("walk")
	jumping = true
	dir = Vector2(rand_range(40, 80), 0).rotated(rand_range(0, TAU))
	if dir.x > 0:
		sprite.flip_h = false
	elif dir.x < 0:
		sprite.flip_h = true


func _on_AnimatedSprite_animation_finished() -> void:
	jumping = false
	sprite.play("idle")
	dir = Vector2.ZERO


func hit(dmg):
	var g = Ghost.instance()
	g.position = position
	G.enemies.call_deferred("add_child", g)
	G.dialog_num = 100
	G.dialog_timer = 0
	queue_free()
