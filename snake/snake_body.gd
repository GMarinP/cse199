extends CharacterBody2D

var TailScene = preload("res://snake_body.tscn")
var head
var parent 

func _physics_process(_delta: float) -> void:
	update_tail()

func set_up():
	var offset = head.direction * -48 
	if head.tail_segments.size() == 0:
		head.segment.global_position = head.last_tile + offset
	else:
		head.segment.global_position = head.tail_segments[-1].global_position + offset

func update_tail():
	head.previous_positions.push_front(head.global_position)
	var needed = head.tail_segments.size() + 1
	if head.previous_positions.size() > needed:
		head.previous_positions.resize(needed)
	for i in range(head.tail_segments.size()):
		head.tail_segments[i].global_position = head.previous_positions[i + 1]
