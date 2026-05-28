extends CharacterBody2D

var previous_positions: Array = []
var tail_segments: Array = []
var TailScene = preload("res://snake_body.tscn")
@onready var head = get_node("/root/TileMap/snakeHead")

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	update_tail()

func update_tail():
	previous_positions.push_front(head.global_position)
	var needed = tail_segments.size() + 1
	if previous_positions.size() > needed:
		previous_positions.resize(needed)
	for i in range(tail_segments.size()):
		tail_segments[i].global_position = previous_positions[i + 1]

func grow_tail():
	var segment = TailScene.instantiate()
	add_child(segment)
	var offset = head.direction * -48 
	if tail_segments.size() == 0:
		segment.global_position = head.global_position + offset
	else:
		segment.global_position = tail_segments[-1].global_position +offset
	tail_segments.append(segment)
