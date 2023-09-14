extends Node2D

@export var range_spawn = 1500
@export var spawn_count = 15
@export_range(0, 1000, 1, "suffix:px") var spawn_until = 300
var _last_pos : Vector2

var asteroid : PackedScene = preload("res://scenes/entity/asteroid/asteroid.tscn")


func _ready() -> void:
	_last_pos = global_position

func _physics_process(delta: float) -> void:
	var cur_pos_len = global_position - _last_pos
	if cur_pos_len.length() > spawn_until:
		spawn()
		_last_pos = global_position


func spawn():
	for i in spawn_count:
		spawn_randomly_in_circle_ring(range_spawn)


func spawn_randomly_in_circle_ring(radius: float) -> void:
	var rand_rot = randi_with_step(0, 360, 15)
	var rand_pos : Vector2 = Vector2.from_angle(deg_to_rad(rand_rot)) * radius
	
	spawn_asteroid(rand_pos + global_position)


## Tolong jangan nganu step <= 0
func randi_with_step(from: int, to: int, step: int = 1) -> int:
	var from_to_mag = to - from
	var rand_num = randi() % from_to_mag / step
	
	return rand_num * step


func spawn_asteroid(pos : Vector2 = Vector2.ZERO):
	var asteroid_instance : Node2D = asteroid.instantiate()
	asteroid_instance.position = pos
	asteroid_instance.rotation = randi_range(0, 360)
	get_tree().get_root().add_child(asteroid_instance)
