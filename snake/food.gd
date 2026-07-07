extends Area2D
# Called when the node enters the scene tree for the first time.

class_name Food
var food_count = 0
@onready var HeadNode = get_node("/root/TileMap/snakeHead")
@export var Background: TileMapLayer

var current_food 
var grid_width = 24
var grid_height = 14
var cell_size = 48

func _ready() -> void:
	randomize()
	spawn_food()

func get_grid_pos():
	return Vector2(round(position.x / 48), round(position.y / 48))

func _physics_process(_delta):
	pass

func spawn_food():
# this function checks for cells that are not walls and spawns food at random spots.
	if not current_food:
		current_food = self
	var position_ok = false
	var new_pos = Vector2.ZERO
	while not position_ok:
		var x = randi() % grid_width
		var y = randi() % grid_height
		var cell = Vector2i(x, y)
		if Background == null: 
			break
		elif Background.get_cell_source_id(cell) == -1:
			position_ok = true
			new_pos = Vector2(x, y) * cell_size
	current_food.position = new_pos
	
func on_raycast_hit():
	queue_free()
	food_count += 1
	print(food_count)
	spawn_food() 
	
