extends KinematicBody2D


const RELOAD_PERIOD := 0.5

onready var Shot = preload("res://Player/Shot.tscn")
onready var sprite := $Sprite
var dir := Vector2.ZERO
#var vel = Vector2.ZERO
var speed := 150.0
var hp := 3.0
var can_fire := true
var reload_time := 0.0
var plaing_animation := false
var first_geath: bool = true


func _ready():
	G.player = self
	redraw_hp()


func redraw_hp():
	$hp.text = str(hp)


func _process(delta):
	if reload_time > 0:
		reload_time -= delta
	else:
		can_fire = true

	dir = Input.get_vector("left", "right", "up", "down")
	move_and_slide(dir * speed)
	
	if Input.is_action_pressed("shot") and can_fire and G.fire_allowed:
		shot()

	if plaing_animation:
		return

	if dir.length() == 0:
		sprite.play("idle")
	else: 
		sprite.play("walk")
		if dir.x > 0:
			sprite.flip_h = false
		elif dir.x < 0:
			sprite.flip_h = true


func shot():
	sprite.play("fire")
	plaing_animation = true
	var s = Shot.instance()
	G.shots.add_child(s)
	var mgp = get_global_mouse_position()
	s.global_position = global_position
	s.look_at(mgp)
	s.vel = global_position.direction_to(mgp) * s.speed
	if mgp.x > global_position.x:
		sprite.flip_h = false
	elif mgp.x < global_position.x:
		sprite.flip_h = true
	
	can_fire = false
	reload_time = RELOAD_PERIOD


func hit(dmg: float):
	hp -= dmg
	redraw_hp()
	print("Player HP: ", hp)
	if hp <= 0:
		death()


func death():
	sprite.play("death")
	plaing_animation = true
	set_process(false)
	if first_geath:
		G.dialog_num = 103
		G.dialog_timer = 0
		first_geath = false
	else:
		G.dialog_num = 200
		G.dialog_timer = 0


func _on_Sprite_animation_finished() -> void:
	plaing_animation = false
