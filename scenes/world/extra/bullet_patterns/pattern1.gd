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

func start():
	bullet_timer.start()

func stop():
	bullet_timer.stop()

func _on_bullet_timer_timeout() -> void:
	# This is how the bullet patten work
	
	var speed = 300
	
	var bullet1 : Bullet = danmaku.instantiate()
	var bullet2 : Bullet = danmaku.instantiate()
	var bullet3 : Bullet = danmaku.instantiate()
	var bullet4 : Bullet = danmaku.instantiate()
	$"..".add_child(bullet1)
	$"..".add_child(bullet2)
	$"..".add_child(bullet3)
	$"..".add_child(bullet4)
	bullet1.global_position = global_position
	bullet2.global_position = global_position
	bullet3.global_position = global_position
	bullet4.global_position = global_position
	bullet1.velocity = speed * Vector2.RIGHT.rotated(bullet_spawn.rotation)
	bullet2.velocity = speed * Vector2.DOWN.rotated(bullet_spawn.rotation)
	bullet3.velocity = speed * Vector2.LEFT.rotated(bullet_spawn.rotation)
	bullet4.velocity = speed * Vector2.UP.rotated(bullet_spawn.rotation)
	bullet_spawn.rotate(deg_to_rad(10))
	
	bullet_sound.play()
