extends Area2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

func get_grid_pos():
	return Vector2(round(position.x / 48), round(position.y / 48))
	
