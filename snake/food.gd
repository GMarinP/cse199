extends Area2D
# Called when the node enters the scene tree for the first time.

signal eaten

var food_count = 0
var current_food 
var grid_width = 24
var grid_height = 14
var cell_size = 48

var Background: Node = null
var HeadNode: Node = null

func _ready() -> void:
	randomize()

func get_grid_pos():
	return Vector2(round(position.x / 48), round(position.y / 48))

func _physics_process(_delta):
	if HeadNode:
		check_collision()

func spawn_food():
# this function checks for cells that are not walls and spawns food at random spots.
	current_food = self
	var position_ok = false
	var new_pos = Vector2.ZERO
	while not position_ok:
		var x = randi() % grid_width
		var y = randi() % grid_height
		var cell = Vector2i(x, y)
		if Background and Background.get_cell_source_id(cell) == -1:
			position_ok = true
			new_pos = Vector2(x, y) * cell_size
	current_food.position = new_pos

func check_collision():
# this function handles food collision with the snake's head 
	if HeadNode.global_position.distance_to(current_food.global_position) < cell_size * 0.5:
		food_count += 1
		emit_signal("eaten")
		spawn_food()
	
