extends TileMap


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	G.dialog_num = 106#ето тест
#	G.fire_allowed = true#ето тест
	G.room_camera = $Camera2D
	G.chest = $Chest/AnimationPlayer
	G.doors = $Doors
