extends Node2D
class_name BulletPattern
## Base class for bullet patterns
##
## All pattern will inherit this then make their own pattern

@export var isStart = false;

## the danmaku scene that will be used
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

func spawn_bullet(bullet, velocity : Vector2, rot_vel : float):
	var bul : Bullet = bullet.instantiate()
	$"..".add_child(bul)
	bul.global_position = bullet_spawn.global_position
	bul.velocity = velocity.rotated(bullet_spawn.rotation)
	bul.ang_vel = rot_vel

func _on_bullet_timer_timeout() -> void:
	pass
