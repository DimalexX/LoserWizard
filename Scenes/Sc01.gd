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
	
	for t in 200: #садим сад вокруг
		t = tree_arr[randi()%4].instance()
		t.position = Vector2(rand_range(200, 1000), 0).rotated(rand_range(0, TAU))
		G.trees.add_child(t)
