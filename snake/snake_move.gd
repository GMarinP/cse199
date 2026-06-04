extends CharacterBody2D

var direction: Vector2 = Vector2(1,0)
var input_dir: Vector2
var speed: float = 200

var tail_segments: Array = []
var previous_positions: Array = []
var TailScene = preload("res://snake_body.tscn")
var last_tile: Vector2
var segment
var food

func _ready() -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_on_area_2d_area_entered(null)
	#if food.food_count %10 :
		#speed += 5
	var input: Vector2 = Input.get_vector("head_left", "head_right", "head_up", "head_down")
	if input and (input.x == 0 or input.y == 0) and ((input.x and not direction.x) or (input.y and not direction.y)):
		input_dir = input
	if global_position.snapped(Vector2(48,48)).distance_to(global_position) <= 2:
		if input_dir:
			global_position = global_position.snapped(Vector2(48,48))
			direction = input_dir
			input_dir = Vector2.ZERO
		last_tile = global_position.snapped(Vector2(48,48))
	velocity = direction * speed
	previous_positions.append(last_tile)
	move_and_slide()

	
func _on_area_2d_area_entered(area: Area2D) -> void:
	#when the head touches fruit this function instantiates a tail segment
	segment = TailScene.instantiate()
	await get_tree().physics_frame
	segment.head = self
	add_sibling(segment)
	tail_segments.append(segment)
	segment.set_up()
