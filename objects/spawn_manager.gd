extends Node2D

## Offset untuk seberapa jauh meteor akan spawn dari satu sama lain
@export var offset : int = 100

@export var asteroids : Array[PackedScene]

var _position_been : Array[Vector2]

var SCREEN_W = ProjectSettings.get_setting("display/window/size/viewport_width")
var SCREEN_H = ProjectSettings.get_setting("display/window/size/viewport_height")

func _ready() -> void:
	print(get_random_without_off(Vector4(0, 0, 3, 3), Vector4(1, 1, 1, 1)))
#	spawn_asteroid_in_area(Vector4(0, 0, 2000, 2000), 50)


#func spawn_asteroid_with_offset(off_area: Vector4, area: Vector4, count: int):
#	for i in count:
#
#


func get_random_without_off(area: Vector4, off_area: Vector4) -> Vector2:
	var x_off_count = off_area.z - off_area.x
	var y_off_count = off_area.w - off_area.y
	var rand_x = randi_range(area.x, x_off_count)
	var rand_y = randi_range(area.y, y_off_count)
	if rand_x >= off_area.x:
		rand_x += x_off_count
	if rand_y >= off_area.y:
		rand_y += y_off_count
	
	return Vector2(rand_x, rand_y)


func spawn_asteroid_in_area(area: Vector4, count: int):
	for i in count:
		var rand_x; var rand_y
		for r in 10:
			rand_x = (randi_range(area.x, area.z) / offset) * offset
			rand_y = (randi_range(area.y, area.w) / offset) * offset
			if not Vector2(rand_x, rand_y) in _position_been:
				break
		
		_position_been.append(Vector2(rand_x, rand_y))
		spawn_random_asteroid(Vector2(rand_x, rand_y))


func spawn_random_asteroid(pos : Vector2 = Vector2.ZERO):
	var ran_num = randi_range(0, len(asteroids) - 1)
	var meteor_instance : Node2D = asteroids[ran_num].instantiate()
	meteor_instance.position = pos
	add_child(meteor_instance)
