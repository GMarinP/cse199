extends CharacterBody2D

var direction = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	
func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("head_left", "head_right", "head_up", "head_down")
	velocity=direction*200
	move_and_slide()
	if input_direction != Vector2(0,0) and (input_direction.x == 0 or input_direction.y == 0):
		direction = input_direction
