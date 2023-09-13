extends Node2D

@export var range_spawn = 1500
@export var spawn_count = 15
@export_range(0, 1000, 1, "suffix:px") var spawn_until = 300
var _last_pos : Vector2

var asteroid : PackedScene = preload("res://objects/asteroid/asteroid.tscn")


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
	var rand_rot = randf_range(0, 360)
	var rand_pos : Vector2 = Vector2.from_angle(deg_to_rad(rand_rot)) * range_spawn
	
	spawn_asteroid(rand_pos + global_position)


func spawn_asteroid(pos : Vector2 = Vector2.ZERO):
	var asteroid_instance : Node2D = asteroid.instantiate()
	asteroid_instance.position = pos
	asteroid_instance.rotation = randi_range(0, 360)
	get_tree().get_root().add_child(asteroid_instance)
