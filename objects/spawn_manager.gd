extends Node2D

## Offset untuk seberapa jauh meteor akan spawn dari satu sama lain
@export var offset : int = 100

@export var asteroids : Array[PackedScene]

var SCREEN_W = ProjectSettings.get_setting("display/window/size/viewport_width")
var SCREEN_H = ProjectSettings.get_setting("display/window/size/viewport_height")

func _ready() -> void:
	spawn_asteroid_in_area(Vector4(0, 0, 2000, 2000), 20)


func spawn_asteroid_in_area(area: Vector4, count: int):
	for i in count:
		var rand_x = (randi_range(area.x, area.z) / offset) * offset
		var rand_y = (randi_range(area.y, area.w) / offset) * offset
		
		spawn_random_asteroid(Vector2(rand_x, rand_y))


func spawn_random_asteroid(pos : Vector2 = Vector2.ZERO):
	var ran_num = randi_range(0, len(asteroids) - 1)
	var meteor_instance : Node2D = asteroids[ran_num].instantiate()
	meteor_instance.position = pos
	add_child(meteor_instance)
