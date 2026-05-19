extends CharacterBody2D



func _ready() -> void:
	pass
	

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
