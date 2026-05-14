extends CharacterBody2D

var direction = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Makes snake head move.
func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("head_left", "head_right", "head_up", "head_down")
	velocity=direction*200
	move_and_slide()
	if input_direction != Vector2(0,0) and (input_direction.x == 0 or input_direction.y == 0):
		direction = input_direction
		
	get_parent().food_collision() 
	
func get_grid_pos():
	return Vector2(round(position.x / 32), round(position.y / 32))
