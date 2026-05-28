extends Node2D

var FoodNode = preload("res://food.tscn")
var food_instantiate = FoodNode.instantiate()
var FoodScript = preload("res://food.gd")
var TailNode = preload("res://snake_body.tscn")
var is_there_food: bool = false
@onready var head = get_node("snakeHead")
@onready var tilemap = self

func _physics_process(delta: float) -> void: 
	if not is_there_food:
		add_child(food_instantiate)
		food_instantiate.spawn_food()
		is_there_food = true
		
	if food_instantiate.food_collision():
		print("food")
		get_node("snakeBody").grow_tail()
	
		
