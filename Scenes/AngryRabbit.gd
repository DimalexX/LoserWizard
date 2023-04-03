extends KinematicBody2D


const J_TIMER = 2
const JT_DELTA = 1

onready var Rabbit = preload("res://Enemies/Rabbit.tscn")
onready var sprite := $AnimatedSprite

var jump_timer: float
var jumping: bool = false
var dir: Vector2 = Vector2.ZERO
var hp = 20


func _ready() -> void:
	jump_timer = rand_range(J_TIMER-JT_DELTA, J_TIMER+JT_DELTA)
	set_process(false)


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
	dir = Vector2(rand_range(60, 120), 0).rotated(rand_range(0, TAU))
	if dir.x > 0:
		sprite.flip_h = false
	elif dir.x < 0:
		sprite.flip_h = true


func _on_AnimatedSprite_animation_finished() -> void:
	jumping = false
	sprite.play("idle")
	dir = Vector2.ZERO


func hit(dmg):
	print("hit")
	hp -= 1
	if hp > 0:
		print("New rabbit")
		var r = Rabbit.instance()
		r.position = position
		G.enemies.call_deferred("add_child", r)
	else:
		G.dialog_num = 300
		G.dialog_timer = 0
		queue_free()
