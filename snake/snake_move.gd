extends CharacterBody2D

var direction: Vector2 = Vector2(1,0)
var input_dir: Vector2
var speed: float = 200

func _ready() -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	var input: Vector2 = Input.get_vector("head_left", "head_right", "head_up", "head_down")
	if input and (input.x == 0 or input.y == 0) and ((input.x and not direction.x) or (input.y and not direction.y)):
		input_dir = input
	if input_dir:
		if global_position.snapped(Vector2(48,48)).distance_to(global_position) <= 4:
			global_position = global_position.snapped(Vector2(48,48))
			direction = input_dir
			input_dir = Vector2.ZERO
	velocity = direction * speed
	move_and_slide()
