extends Node2D

var FoodNode = preload("res://food.tscn")
var food_instantiate: Node = null
var TailNode = preload("res://snake_body.tscn")
var is_there_food: bool = false
@onready var head = get_node("snakeHead")
@onready var tilemap = self

func _physics_process(delta: float) -> void:
	if not is_there_food:
		# create a fresh instance (or reuse, but set references)
		food_instantiate = FoodNode.instantiate()
		# inject references so food.gd doesn't use absolute paths
		food_instantiate.Background = tilemap
		food_instantiate.HeadNode = head
		add_child(food_instantiate)
		food_instantiate.spawn_food()
		# connect the eaten signal
		food_instantiate.connect("eaten", Callable(self, "_on_food_eaten"))
		is_there_food = true

func on_food_eaten():
	print("food")
	var snake_body = get_node("snakeBody")
	if snake_body:
		snake_body.grow_tail()

	
		
