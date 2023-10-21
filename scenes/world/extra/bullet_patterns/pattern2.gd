extends Node2D

@export var isStart = false;

var danmaku : PackedScene = preload("res://scenes/entity/bullets/bullet1.tscn")
@onready var bullet_timer : Timer = $BulletTimer
@onready var bullet_spawn : Node2D = $bulletSpawn
@onready var bullet_sound : AudioStreamPlayer = $BulletSound

func _ready() -> void:
	if not bullet_timer.timeout.is_connected(_on_bullet_timer_timeout):
		bullet_timer.timeout.connect(_on_bullet_timer_timeout)
	if isStart:
		start();

# Start bullet
func start():
	bullet_timer.start()

# Stop bullet
func stop():
	bullet_timer.stop()

func spawn_bullet(bullet, velocity : Vector2):
	var bul : Bullet = bullet.instantiate()
	$"..".add_child(bul)
	bul.global_position = bullet_spawn.global_position
	bul.velocity = velocity.rotated(bullet_spawn.rotation)

func spawn_bullets_in_circle(bullet, count, speed):
	var rot_snap= 360 / count
	var cur_rot = 0
	for b in range(count):
		spawn_bullet(bullet, Vector2.RIGHT.rotated(cur_rot) * speed)
		cur_rot += deg_to_rad(rot_snap)

func _on_bullet_timer_timeout() -> void:
	# This is how the bullet patten work
	# Pattern ini bakal bikin bullet circle
	
	var speed = 300
	var bullet_count = 15
	
	spawn_bullets_in_circle(danmaku, bullet_count, speed)
	
	bullet_spawn.rotate(deg_to_rad(30))
	
	bullet_sound.play()
