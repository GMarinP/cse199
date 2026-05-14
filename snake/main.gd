extends Node2D

var FoodScene = preload("res://food.tscn")
var current_food

var grid_width = 20
var grid_height = 20
var cell_size = 32

@onready var head = get_node("snakeHead")

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
		new_pos = Vector2(x, y) * cell_size

		position_ok = true
		for wall in get_tree().get_nodes_in_group("wall"):
			if wall.position == new_pos:
				position_ok = false
				break

	current_food.position = new_pos
	add_child(current_food)

func food_collision():
	if head.get_grid_pos() == current_food.get_grid_pos():
		spawn_food()
