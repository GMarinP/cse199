extends Node2D

var FoodScene = preload("res://food.tscn")
var TailScene = preload("res://snake_body.tscn")
var tail_segments = []
var previous_positions = []
var current_food
var grid_width = 24
var grid_height = 14
var cell_size = 48

@onready var head = get_node("snakeHead")
@onready var tilemap = self 

func _ready():
	spawn_food()
	
func _physics_process(delta):
	food_collision()
	update_tail()

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
	if head.global_position.distance_to(current_food.global_position) < 24:
		spawn_food()
		grow_tail()
		
func update_tail():
	# Record the head's position each frame
	previous_positions.push_front(head.global_position)

	# Keep only enough positions for the tail length
	var needed = tail_segments.size() + 1
	if previous_positions.size() > needed:
		previous_positions.resize(needed)

	# Move each tail segment to the position the head used to be in
	for i in range(tail_segments.size()):
		tail_segments[i].global_position = previous_positions[i + 1]

func grow_tail():
	var segment = TailScene.instantiate()
	add_child(segment)

	# Place it at the last known tail position
	if tail_segments.size() == 0:
		segment.global_position = head.global_position
	else:
		segment.global_position = tail_segments[-1].global_position
		tail_segments.append(segment)
