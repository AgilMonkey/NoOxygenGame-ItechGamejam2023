extends BulletPattern

# Double flower pattern
@onready var danmaku2 = preload("res://scenes/entity/bullets/bullet2.tscn")
@export var num_bullet : int = 8
@export_range(0, 100, 0.1,"or_less", "or_greater", "degrees") var rot_speed : float = 30
@export var bul_speed = 250
var positive = 1

func spawn_bullets_in_circle(bullet, count, speed, _rot_speed):
	var rot_snap= 360 / count
	var cur_rot = 0
	for b in range(count):
		spawn_bullet(bullet, Vector2.RIGHT.rotated(cur_rot) * speed, _rot_speed)
		cur_rot += deg_to_rad(rot_snap)

func _on_bullet_timer_timeout():
	spawn_bullets_in_circle(danmaku2, num_bullet, bul_speed, deg_to_rad(rot_speed) * positive)
	positive = -positive
	bullet_spawn.rotate(deg_to_rad(20))
	
	bullet_sound.play()
