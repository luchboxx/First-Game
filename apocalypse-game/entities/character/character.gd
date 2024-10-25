extends CharacterBody3D
class_name Character

signal died

@export var archetype : Archetype

@onready var active_camera = get_viewport().get_camera_3d()
@onready var character_sprites : Array[Node] = find_children("", "SpriteBase3D")

var health_current : int :
	get:
		return health_current
	set(value):
		health_current = clamp(value, 0, archetype.max_health)
		if health_current <= 0:
			died.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_current = archetype.max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active_camera:
		for sprite in character_sprites:
			sprite = sprite as Node3D
			sprite.look_at(Vector3(global_position.x, active_camera.global_position.y, active_camera.global_position.z))

## moves the entity in the direction of the provided Vector2
func move(direction : Vector3, acceleration_modifier : float, delta : float):
	velocity = velocity.move_toward(direction * archetype.move_speed, (archetype.acceleration * acceleration_modifier) * delta)
	velocity += get_gravity() * delta
	print(velocity)

	move_and_slide()

func health_add(value):
	health_current += value

func health_remove(value):
	health_current -= value
