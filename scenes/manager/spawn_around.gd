extends Node2D

@export var range_spawn = 1500
@export var asteroids_spawn_count = 15
@export var oxygen_spawn_count = 5
@export_range(0, 1000, 1, "suffix:px") var spawn_until = 300
var _last_pos : Vector2

@export var asteroids : Array[PackedScene]
var oxygen_tank : PackedScene = preload("res://scenes/entity/oxygen/oxygen_tank.tscn")


func _ready() -> void:
	_last_pos = global_position

func _physics_process(delta: float) -> void:
	var cur_pos_len = global_position - _last_pos
	if cur_pos_len.length() > spawn_until:
		spawn()
		_last_pos = global_position


func spawn():
	for i in asteroids_spawn_count:
		spawn_randomly_in_circle_ring(asteroids.pick_random(), range_spawn)
	for j in oxygen_spawn_count:
		spawn_randomly_in_circle_ring(oxygen_tank, range_spawn)


func spawn_randomly_in_circle_ring(obj: PackedScene, radius: float) -> void:
	var rand_rot = randi_with_step(0, 360, 15)
	var rand_pos : Vector2 = Vector2.from_angle(deg_to_rad(rand_rot)) * radius
	
	spawn_something_with_random_prop(obj, rand_pos + global_position)


## Tolong jangan nganu step <= 0
func randi_with_step(from: int, to: int, step: int = 1) -> int:
	var from_to_mag = to - from
	var rand_num = randi() % from_to_mag / step
	
	return rand_num * step


func spawn_something_with_random_prop(obj: PackedScene, pos: Vector2 = Vector2.ZERO):
	var instance : Node2D = obj.instantiate()
	instance.position = pos
	instance.rotation = randi_range(0, 360)
	get_tree().get_root().add_child(instance)


#func spawn_asteroids(pos : Vector2 = Vector2.ZERO):
#	var asteroids_instance : Node2D = spawn_something(asteroids)
#	asteroids_instance.position = pos
#	asteroids_instance.rotation = randi_range(0, 360)
#	get_tree().get_root().add_child(asteroids_instance)
#
#
#func spawn_something(obj: PackedScene):
#	var instance : Node2D = obj.instantiate()
#	return instance
