extends Node

onready var Crow = preload("res://Enemies/Crow.tscn")

var enemies: Node2D
var shots: Node2D
var trees: Node2D
var label: Label
var dialog: Sprite
var label2: Label
var dialog2: Sprite
var hp_label: Label
var hp_label2: Label
var player: KinematicBody2D
var bs_animation: AnimationPlayer
var blackscreen: ColorRect
var sc01: Node2D
var room01: Node2D
var room_camera: Camera2D
var chest: AnimationPlayer
var doors: Node2D
var ppos: Vector2
var angry: KinematicBody2D
var bossroom: Node2D

var fire_allowed: bool = false
var dialog_timer: float = 1.0
var dialog_num: int = 0
var cursed: bool = false
var level: int = 1


func _ready() -> void:
	randomize()


func _process(delta: float) -> void:
	#на придумывание этой системы диалогов ушло меньше минуты ))) в рамках джема - живет ;)
	if Input.is_action_just_pressed("ui_cancel"):
		dialog_timer = 0
	else:
		dialog_timer -= delta
	if dialog_timer <= 0:
		match dialog_num:
			0:
				dialog.show()
				label.text = "Добро пожаловать в приключения Волшебника-неудачника!"
				dialog_timer = 5
				dialog_num += 1
			1:
				label.text = "Для движения нужно применить заклинание W,A,S,D!"
				dialog_timer = 5
				dialog_num += 1
			2:
				label.text = "Ну или показывай направление стрелками!"
				dialog_timer = 5
				dialog_num += 1
			3:
				label.text = "Уверен, ты справился! Даже проверять не буду ;)"
				dialog_timer = 5
				dialog_num += 1
			4:
				label.text = "Для атаки нужно сосредоточиться и нажать кнопку мыши!"
				dialog_timer = 5
				dialog_num += 1
			5:
				label.text = "Потренируйся!"
				dialog_timer = 2
				dialog_num += 1
				fire_allowed = true
			6:
				dialog_timer = 100
				dialog_num += 1
				dialog.hide()
			7:
				label.text = "Какой ты добрый! Не стреляешь в зайчика!"
				dialog.show()
				dialog_timer = 5
				dialog_num += 1
			8:
				dialog.hide()
				dialog_num += 1
			100: #проклятие и вторая фаза
				label.text = "За что зайчика?!"
				dialog.show()
				dialog_timer = 2.5
				dialog_num += 1
			101:
				dialog.hide()
				label2.text = "Колдун, ты будешь проклят! Удача покинет тебя!"
				dialog2.show()
				dialog_timer = 5
				dialog_num += 1
			102:
				dialog2.hide()
				cursed = true
				dialog_timer = 600
			103: #дерево
				label.text = "Ну вот! Как быстро тебя покинула удача!"
				dialog.show()
				dialog_timer = 5
				dialog_num += 1
			104:
				bs_animation.play("black")
				blackscreen.show()
				label.text = "Совершенно случайно попал под падающее дерево..."
				dialog.show()
				dialog_timer = 5
				dialog_num += 1
			105: #начало подземелья
				bs_animation.play("unblack")
				room01.show()
				room_camera.current = true
				sc01.remove_child(player)
				sc01.hide()
				room01.add_child(player)
				shots = room01.get_node("Shots")
				enemies = room01.get_node("Enemies")
				new_room(0, true)
				hp_label.show()
				label.text = "Но что же это?! Неужели смерть - это не конец?"
				dialog.show()
				dialog_timer = 5
				dialog_num += 1
			106:
				dialog.hide()
				dialog_timer = 600
			150: #удачный сундук
				label.text = "Неужели ты сохранил частицу удачи?"
				dialog.show()
				dialog_timer = 3
				dialog_num += 1
			151:
				dialog.hide()
				dialog_timer = 600
			160: #неудачный сундук
				label.text = "Вот это сокровище! Удача точно покинула тебя!"
				dialog.show()
				dialog_timer = 3
				dialog_num += 1
			161:
				dialog.hide()
				dialog_timer = 600
			200: #смерть в подземелье
				#лютая фигня ...
				room_camera.current = true
				room01.add_child(player)
				shots = room01.get_node("Shots")
				enemies = room01.get_node("Enemies")
				new_room(0, true)
				level = 1
				#здесь выбор из нескольких фраз, чтоб не надоели ;)
				label.text = "Или все же смерть - конец..."
				dialog.show()
				dialog_timer = 3
				dialog_num += 1
				bs_animation.play("black")
			201:
				bs_animation.play("unblack")
				#здесь выбор из нескольких фраз, чтоб не надоели ;)
				label.text = "Нет! Герой поднимается из последних сил!"
				dialog_timer = 3
				dialog_num += 1
				new_room(0, true)
			202:
				dialog.hide()
				dialog_timer = 600
			250:
				label2.text = "Р-Р-Р-Р-Р!!!"
				dialog2.show()
				dialog_timer = 2
				dialog_num += 1
			251:
				dialog2.hide()
				label.text = "Или как там зайцы рычат? ;)"
				dialog.show()
				dialog_timer = 2
				dialog_num += 1
			252:
				dialog.hide()
				dialog_timer = 600
			300: #победа босса
				dialog_timer = 5
				dialog_num += 1
				bs_animation.play("black")
			301:
				label.text = "Wake up, Neo..."
				dialog.show()
				dialog_timer = 5
				dialog_num += 1
			302:
				label.text = "Game jam is over..."
				dialog_timer = 300
				dialog_num += 1
			303:
				get_tree().quit()


func new_room(player_pos: int, death: bool = false):
	level += 1
	print(level)
	
	if death:
#		print("after death")
		player.hp = 3
		player.redraw_hp()
		player.set_process(true)
		level = 2
#		print(level)
	
	if level > 5: #boss
		player.global_position = ppos
		shots = bossroom.get_node("Shots")
		enemies = bossroom.get_node("Enemies")
		angry.set_process(true)
		var camera = player.get_node("Camera2D")
		camera.current = true
		camera.limit_left = 1728
		camera.limit_top = 640
		camera.limit_right = 2208
		camera.limit_bottom = 1024
		G.hp_label2.show()
		G.dialog_num = 250
		G.dialog_timer = 0
		return
	
	for c in enemies.get_children():
		enemies.remove_child(c)
		c.queue_free()
	var enemy_positions := []
	match player_pos:
		0:
			player.position = room01.get_node("Pos0").position
			enemy_positions = [room01.get_node("EnemyPos8"), room01.get_node("EnemyPos9"),
				room01.get_node("EnemyPos10"), room01.get_node("EnemyPos11"), room01.get_node("EnemyPos12")]
		1:
			player.position = room01.get_node("Pos1").position
			enemy_positions = [room01.get_node("EnemyPos3"), room01.get_node("EnemyPos5"),
				room01.get_node("EnemyPos7"), room01.get_node("EnemyPos9"), room01.get_node("EnemyPos12")]
		2:
			player.position = room01.get_node("Pos2").position
			enemy_positions = [room01.get_node("EnemyPos1"), room01.get_node("EnemyPos2"),
				room01.get_node("EnemyPos3"), room01.get_node("EnemyPos4"), room01.get_node("EnemyPos5")]
		3:
			player.position = room01.get_node("Pos3").position
			enemy_positions = [room01.get_node("EnemyPos1"), room01.get_node("EnemyPos4"),
				room01.get_node("EnemyPos6"), room01.get_node("EnemyPos8"), room01.get_node("EnemyPos10")]
	var e
	var index
	for i in num_enemies_by_level():
		e = Crow.instance()
		index = randi()%enemy_positions.size()
		e.position = enemy_positions[index].position
		enemies.call_deferred("add_child", e)
		enemy_positions.remove(index)
	
	chest.play("return")
	doors.position.x = 0


func take_chest(pos):
	var luck = randi()%100
	if luck < 30: #вероятность плюшки 30%
		player.hp += 2
		player.redraw_hp()
		G.dialog_num = 150
		G.dialog_timer = 0
	else:
		var e
		for i in 3:
			e = Crow.instance()
			e.position = pos + Vector2(70, 0).rotated(rand_range(0, TAU))
			enemies.call_deferred("add_child", e)
		G.dialog_num = 160
		G.dialog_timer = 0


func check_enemies():
	if enemies.get_children().size() <= 1:
		doors.position.x = -500 #элегантно, не правда ли мы открываем двери )))


func num_enemies_by_level():
	return min(level/2, 5)
	print(level)
