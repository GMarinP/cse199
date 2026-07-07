extends Node2D

var direction: Vector2 = Vector2(0,-1)
var input_dir: Vector2
var last_frame: Vector2
var score: int = 0
@onready var ray: RayCast2D = $Icon/ray
var speed: int = 4

const BODY_SEGMENT: PackedScene = preload("res://snake_body.tscn")
var segments: Array[StaticBody2D]

func _physics_process(_delta: float) -> void:
	ray.force_raycast_update()
	if ray.is_colliding():
		if ray.get_collider() is Food:
			ray.get_collider().on_raycast_hit()
		elif ray.get_collider() is TileMapLayer or ray.get_collider() is StaticBody2D:
			get_tree().reload_current_scene()
	if Input.is_action_pressed("ui_text_delete"):
		return
	var input: Vector2 = Input.get_vector("head_left", "head_right", "head_up", "head_down")
	if input and (input.x == 0 or input.y == 0) and ((input.x and not direction.x) or (input.y and not direction.y)):
		input_dir = input
	last_frame = global_position
	global_position += direction * speed
	if global_position.snapped(Vector2(3,3)) == global_position.snapped(Vector2(48,48)):
		update()
	if Input.is_action_just_pressed("ui_accept"):
		score += 1
		print(score)
		@warning_ignore("integer_division")
		for i in range(24 / speed + 1):
			await get_tree().process_frame
			add_segment()

func add_segment():
	var new_segment: StaticBody2D = BODY_SEGMENT.instantiate()
	if segments.size() == 0:
		new_segment.parent = self
	else:
		new_segment.parent = segments[-1]
	segments.append(new_segment)
	add_sibling(new_segment)
	new_segment.global_position = new_segment.parent.global_position

func update() -> void:
	if input_dir:
		direction = input_dir
		$Icon.look_at($Icon.global_position + direction)
		$Icon.rotation_degrees += 180
		global_position = global_position.snapped(Vector2(48,48))
		input_dir = Vector2.ZERO

func _on_area_2d_area_entered(_area: Area2D) -> void:
	#when the head touches fruit this function instantiates a tail segment
	await get_tree().physics_frame
	add_segment()
