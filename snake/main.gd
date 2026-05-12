extends Node2D

var FoodScene = preload("res://food.tscn")
var grid_width = 20
var grid_height = 20
var cell_size = 32

func spawn_food():
	var food = FoodScene.instantiate()

	var x = randi() % grid_width
	var y = randi() % grid_height

	food.position = Vector2(x, y) * cell_size
	add_child(food)
