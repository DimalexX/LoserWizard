extends KinematicBody2D


onready var sprite = $AnimatedSprite

var speed := 70
var dir := Vector2.ZERO
var hp := 5.0
var plaing_animation := false
var spawn_timer := 1.0


func _ready():
	redraw_hp()


func redraw_hp():
	$hp.text = str(hp)


func _process(delta):
	if spawn_timer > 0:
		spawn_timer -= delta
		return
	if plaing_animation: return
	if G.player:
		if global_position.distance_to(G.player.global_position) > 10 \
			and global_position.distance_to(G.player.global_position) < 400: #привет, Паштет! ;)
			dir = global_position.direction_to(G.player.global_position)
			move_and_slide(dir * speed)
		else:
			dir = Vector2.ZERO

		if dir.length() == 0:
			sprite.play("idle")
		else: 
			sprite.play("walk")
			if dir.x > 0:
				sprite.flip_h = false
			elif dir.x < 0:
				sprite.flip_h = true


func hit(dmg: float):
	hp -= dmg
	redraw_hp()
	sprite.play("damage")
	plaing_animation = true
	if hp <= 0:
		death()


func death():
	$CollisionShape2D.set_deferred("disabled", true)
	$AreaAttack.monitoring = false
	sprite.play("death")
	plaing_animation = true


func _on_AnimatedSprite_animation_finished() -> void:
	plaing_animation = false
	if sprite.animation == "death":
		queue_free()
		G.check_enemies()


func _on_AreaAtack_body_entered(body: Node) -> void:
	body.hit(1)
	sprite.play("attack")
	plaing_animation = true
