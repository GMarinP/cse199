extends StaticBody2D


var parent: Node2D
var last_frame: Vector2

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_text_delete"):
		return
	last_frame = global_position
	global_position = parent.last_frame
