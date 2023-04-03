extends TileMap


func _ready() -> void:
	G.room_camera = $Camera2D
	G.chest = $Chest/AnimationPlayer
	G.doors = $Doors
