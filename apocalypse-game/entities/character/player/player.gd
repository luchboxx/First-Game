extends Character
class_name Player

var knowledge_points := 0

func _physics_process(delta: float) -> void:
	var direction = Vector3(Input.get_axis("move_left", "move_right"), 0, Input.get_axis("move_up", "move_down"))

	move(direction, delta)
