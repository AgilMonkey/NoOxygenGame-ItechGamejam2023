extends Node2D

## Offset untuk seberapa jauh meteor akan spawn dari satu sama lain
#@export var step : int = 100

@export var start_spawn_area := Vector4(-1000, -1000, 2000, 2000)
@export var start_spawn_offs_area := Vector4(200, 200, 600, 600)
@export var asteroid_spawn_count := 100
@export var oxygen_spawn_count := 20

@export var asteroids : Array[PackedScene]
var oxygen_tank : PackedScene = preload("res://scenes/entity/oxygen/oxygen_tank.tscn")

var _position_been : Array[Vector2]

var SCREEN_W = ProjectSettings.get_setting("display/window/size/viewport_width")
var SCREEN_H = ProjectSettings.get_setting("display/window/size/viewport_height")

func _ready() -> void:
	spawn_asteroid_with_offset(start_spawn_area, start_spawn_offs_area, asteroid_spawn_count)
	for i in oxygen_spawn_count:
		var rand_pos = get_random_pos(start_spawn_area, start_spawn_offs_area)
		spawn_something_with_random_prop(oxygen_tank, rand_pos)
	

func spawn_asteroid_with_offset(area: Vector4, off_area: Vector4, count: int):
	for i in count:
		var rand_pos = get_random_pos(area, off_area)
		spawn_random_asteroid(rand_pos)


func get_random_pos(area: Vector4, off_area: Vector4) -> Vector2:
	var rand_pos : Vector2
	for j in range(0, 10):
		rand_pos = get_random_without_off(area, off_area)
		
		if not rand_pos in _position_been:
			break
	
	_position_been.append(rand_pos)
	return rand_pos


func get_random_without_off(area: Vector4, off_area: Vector4, step: int = 0) -> Vector2:
	var x_pos : Array = range(area.x, area.z+1)
	var y_pos : Array = range(area.y, area.w+1)
	var x_off_pos : Array = range(off_area.x, off_area.z)
	var y_off_pos : Array = range(off_area.y, off_area.w)
	
	if len(x_off_pos) > 0:
		x_pos = remove_all_array_in_arr(x_pos, x_off_pos)
	if len(y_off_pos) > 0:
		y_pos = remove_all_array_in_arr(y_pos, y_off_pos)
	
	var x = x_pos.pick_random()
	var y = y_pos.pick_random()
	
	return Vector2(x, y)


func remove_all_array_in_arr(arr: Array, rem: Array) -> Array:
	for r in rem:
		arr.erase(r)
	
	return arr


#func spawn_asteroid_in_area(area: Vector4, count: int):
#	for i in count:
#		var rand_x; var rand_y
#		for r in 10:
#			rand_x = (randi_range(area.x, area.z) / offset) * offset
#			rand_y = (randi_range(area.y, area.w) / offset) * offset
#			if not Vector2(rand_x, rand_y) in _position_been:
#				break
#
#		_position_been.append(Vector2(rand_x, rand_y))
#		spawn_random_asteroid(Vector2(rand_x, rand_y))


func spawn_random_asteroid(pos : Vector2 = Vector2.ZERO):
	var ran_num = randi_range(0, len(asteroids) - 1)
	var random_asteroid = asteroids[ran_num]
	spawn_something_with_random_prop(random_asteroid, pos)

func spawn_something_with_random_prop(obj: PackedScene, pos: Vector2 = Vector2.ZERO):
	var instance : Node2D = obj.instantiate()
	instance.position = pos
	instance.rotation = randi_range(0, 360)
	add_child(instance)


func _on_astronot_on_death() -> void:
	print("HEHE HAHA")
