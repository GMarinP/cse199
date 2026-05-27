extends Area2D
# Called when the node enters the scene tree for the first time.

var food_count = 0
var HeadScript = load("res://snake_move.gd")
var SnakeBody = load("res://snake_body.gd")
@onready var Background = get_node("/root/TileMap")
@onready var HeadNode = get_node("/root/TileMap/snakeHead")

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
	food_collision()

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
		if Background.get_cell_source_id(cell) == -1:
			position_ok = true
			new_pos = Vector2(x, y) * cell_size
	current_food.position = new_pos

func food_collision():
# this function handles food collision with the snake's head 
	if HeadNode.global_position.distance_to(current_food.global_position) < cell_size:
		food_count += 1
		print(food_count)
		spawn_food()
	return false
