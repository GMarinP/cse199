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
	$CollisionShape2D.disabled = false
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func on_body_entered(body):
	if body.name == "snakeHead":   # or check for a script/class
		food_count += 1
		emit_signal("eaten")
		spawn_food()

func get_grid_pos():
	return Vector2(round(position.x / 48), round(position.y / 48))

func _physics_process(_delta):
	if HeadNode:
		check_collision()

func spawn_food():
	# Build list of free cells using the TileMapLayer API
	var free_cells: Array = []
	var used_rect = Background.get_used_rect()  # Rect2i: position and size in cell coords

	for x in range(used_rect.position.x, used_rect.position.x + used_rect.size.x):
		for y in range(used_rect.position.y, used_rect.position.y + used_rect.size.y):
			var cell = Vector2i(x, y)
			var tile_id = Background.get_cell_tile_id(cell)  # TileMapLayer method
			if tile_id == -1:
				free_cells.append(cell)

	if free_cells.is_empty():
		push_warning("No free cells found to spawn food.")
		return

	var chosen = free_cells[randi() % free_cells.size()]
	# Convert chosen cell to world position and center the Area2D in the tile
	var world_pos = Background.map_to_world(chosen) + Background.cell_size * 0.5
	position = world_pos
	current_food = self

func check_collision():
# this function handles food collision with the snake's head 
	if HeadNode.global_position.distance_to(current_food.global_position) < cell_size * 0.5:
		food_count += 1
		emit_signal("eaten")
		spawn_food()
