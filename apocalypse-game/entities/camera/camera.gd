extends SpringArm3D

@onready var camera_3d: Camera3D = $Camera3D

@export var follow_target : Node3D
@export var interpolation_speed := 1

func _physics_process(delta):
	if follow_target:
		global_position = lerp(global_position, follow_target.global_position, interpolation_speed * delta)
