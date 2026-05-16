extends Node2D

var FoodScene = preload("res://food.tscn")
var current_food
var grid_width = 24
var grid_height = 14
var cell_size = 48

@onready var head = get_node("snakeHead")
@onready var tilemap = self 

func _ready():
	spawn_food()

func spawn_food():
	if current_food:
		current_food.queue_free()
		
	current_food = FoodScene.instantiate()
	
	var position_ok = false
	var new_pos = Vector2.ZERO
	
	while not position_ok:
		var x = randi() % grid_width
		var y = randi() % grid_height
		var cell = Vector2i(x, y)
		
		if tilemap.get_cell_source_id(cell) == -1:
			position_ok = true
			new_pos = Vector2(x, y) * cell_size
			
	current_food.position = new_pos
	add_child(current_food)
	
func food_collision():
	if head.get_grid_pos() == current_food.get_grid_pos():
		spawn_food()
