extends Node2D


func _ready() -> void:
	G.dialog = $CanvasLayer/Dialog
	G.label = $CanvasLayer/Dialog/Label
	G.dialog2 = $CanvasLayer/Dialog2
	G.label2 = $CanvasLayer/Dialog2/Label
	G.bs_animation = $CanvasLayer/Blackscreen/AnimationPlayer
	G.blackscreen = $CanvasLayer/Blackscreen
	G.sc01 = $Sc01
	G.room01 = $Room01
	G.bossroom = $BossRoom
	
	G.dialog_num = 105#ето тест
	G.fire_allowed = true#ето тест
