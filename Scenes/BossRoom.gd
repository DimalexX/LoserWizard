extends TileMap


func _ready() -> void:
	G.ppos = $PPos.global_position
	G.angry = $AngryRabbit
