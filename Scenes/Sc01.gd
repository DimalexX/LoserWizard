extends Node2D


onready var tree_arr := [preload("res://Scenes/Trees/Tree01.tscn"),
	preload("res://Scenes/Trees/Tree02.tscn"),
	preload("res://Scenes/Trees/Tree03.tscn"),
	preload("res://Scenes/Trees/Tree04.tscn")]


func _ready():
	randomize()
	G.enemies = $Enemies
	G.shots = $Shots
	G.trees = $Trees
	
	for t in 200:
		t = tree_arr[randi()%4].instance()
		t.position = Vector2(rand_range(200, 1000), 0).rotated(rand_range(0, TAU))
		G.trees.add_child(t)


#func _process(delta: float) -> void:
#	if Input.is_action_just_pressed("ui_cancel"):
#		G.dialog_timer = 0
#	else:
#		G.dialog_timer -= delta
#	if G.dialog_timer <= 0:
#		match G.dialog_num:
#			0:
#				G.dialog.show()
#				G.label.text = "Добро пожаловать в приключения Волшебника-неудачника!"
#				G.dialog_timer = 5
#				G.dialog_num += 1
#			1:
#				G.label.text = "Для движения нужно применить заклинание W,A,S,D!"
#				G.dialog_timer = 5
#				G.dialog_num += 1
#			2:
#				G.label.text = "Ну или показывай направление стрелками!"
#				G.dialog_timer = 5
#				G.dialog_num += 1
#			3:
#				G.label.text = "Уверен, ты справился! Даже проверять не буду ;)"
#				G.dialog_timer = 5
#				G.dialog_num += 1
#			4:
#				G.label.text = "Для атаки нужно сосредоточиться и нажать кнопку мыши!"
#				G.dialog_timer = 5
#				G.dialog_num += 1
#			5:
#				G.label.text = "Потренируйся!"
#				G.dialog_timer = 2
#				G.dialog_num += 1
#				G.fire_allowed = true
#			6:
#				G.dialog_timer = 180
#				G.dialog_num += 1
#				G.dialog.hide()
#			7:
#				G.label.text = "Какой ты добрый! Не стреляешь в зайчика!"
#				G.dialog.show()
#				G.dialog_timer = 5
#				G.dialog_num += 1
#			8:
#				G.dialog.hide()
#				G.dialog_num += 1
#			100:
#				G.label.text = "За что зайчика?!"
#				G.dialog.show()
#				G.dialog_timer = 2.5
#				G.dialog_num += 1
#			101:
#				G.dialog.hide()
#				G.label2.text = "Ты будешь проклят! Удача покинет тебя!"
#				G.dialog2.show()
#				G.dialog_timer = 5
#				G.dialog_num += 1
#			102:
#				G.dialog2.hide()
#				G.cursed = true
#				G.dialog_timer = 600
#			103:
#				G.label.text = "Ну вот! Как быстро тебя покинула удача!"
#				G.dialog.show()
#				G.dialog_timer = 5
#				G.dialog_num += 1
#			104:
#				G.blackscreen.play("black")
#				G.label.text = "Совершенно случайно попал под падающее дерево.."
#				G.dialog.show()
#				G.dialog_timer = 5
#				G.dialog_num += 1
