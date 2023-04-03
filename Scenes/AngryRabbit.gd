extends KinematicBody2D


const J_TIMER = 1
const JT_DELTA = .5

onready var Rabbit := preload("res://Enemies/Rabbit.tscn")
onready var sprite := $AnimatedSprite

var jump_timer: float
var jumping: bool = false
var dir: Vector2 = Vector2.ZERO
var hp: float = 20
var ghost_mode: bool = false


func _ready() -> void:
	jump_timer = rand_range(J_TIMER-JT_DELTA, J_TIMER+JT_DELTA)
	set_process(false) #ждем прихода ГГ
	redraw_hp()


func redraw_hp():
	if G.hp_label2:
		G.hp_label2.text = "HP:" + str(hp)


func _process(delta: float) -> void:
	if get_tree().get_nodes_in_group("Rabbit").size() > 2:
		sprite.modulate = Color(1, 0, .2, .5)
		ghost_mode = true
	else:
		sprite.modulate = Color(1, 0, .2, 1)
		ghost_mode = false

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
#	dir = Vector2(rand_range(100, 200), 0).rotated(rand_range(0, TAU))
	dir = global_position.direction_to(G.player.global_position) * 200
	if dir.x > 0:
		sprite.flip_h = false
	elif dir.x < 0:
		sprite.flip_h = true


func _on_AnimatedSprite_animation_finished() -> void:
	jumping = false
	sprite.play("idle")
	dir = Vector2.ZERO


func hit(dmg):
	if not ghost_mode:
		hp -= 1
		redraw_hp()
	if hp > 0:
		var r = Rabbit.instance()
		r.position = position
		r.J_TIMER = 1
		r.JT_DELTA = 0.5
		r.get_node("AnimatedSprite").modulate = Color(1, 0, 0.2, 1)
		G.enemies.call_deferred("add_child", r)
	else:
		G.dialog_num = 300
		G.dialog_timer = 0
		queue_free()


func _on_Area2D_body_entered(body: Node) -> void:
	body.hit(1)
#	sprite.play("attack")
#	plaing_animation = true
