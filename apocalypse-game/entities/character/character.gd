extends CharacterBody2D
class_name Character

signal died

@export var archetype : Archetype

var health_current : int :
	get:
		return health_current
	set(value):
		health_current = clamp(value, 0, archetype.max_health)
		if health_current <= 0:
			died.emit()

var acceleration = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_current = archetype.max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## moves the entity in the direction of the provided Vector2
func move(direction : Vector2, delta : float):
	velocity = velocity.move_toward(direction.normalized() * archetype.move_speed, acceleration * delta)

	move_and_slide()

func health_add(value):
	health_current += value

func health_remove(value):
	health_current -= value
