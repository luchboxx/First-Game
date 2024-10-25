extends Character
class_name Player

@onready var dash_timer: Timer = $DashTimer
@onready var dash_cooldown: Timer = $DashCooldown

var knowledge_points := 0
var can_dash = true

var direction := Vector3.ZERO

func _ready() -> void:
	assert(archetype is PlayerArchetype, "Given archetype is not a PlayerArchetype")

	super()
	#dash_timer.set_wait_time(archetype.dash_timer)
	#dash_cooldown.set_wait_time(archetype.dash_cooldown)

func _physics_process(delta: float) -> void:

	if can_dash && Input.is_action_just_pressed("dash"):
		dash_timer.start()
		can_dash = false

	if !dash_timer.is_stopped():
		direction *= archetype.dash_speed
		move(direction, archetype.dash_acceleration, delta)
	else:
		direction = Vector3(Input.get_axis("move_left", "move_right"), 0, Input.get_axis("move_up", "move_down")).normalized()
		move(direction, 1, delta)


func _on_dash_timer_timeout() -> void:
	dash_cooldown.start()


func _on_dash_cooldown_timeout() -> void:
	can_dash = true
