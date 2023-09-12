extends CharacterBody2D

var speed := 300.0
var rot_speed := 4

var _input_dir := Vector2.ZERO
var _rot_dir := 0


func _physics_process(delta: float) -> void:
	# Input
	_input_dir.y = Input.get_action_raw_strength("move_back") - Input.get_action_raw_strength("move_forward")
	_rot_dir = 0
	if Input.is_action_pressed("move_right"):
		_rot_dir += 1
	if Input.is_action_pressed("move_left"):
		_rot_dir -= 1
	
	# Physics
	velocity += Vector2(0, _input_dir.y * speed * delta).rotated(rotation)
	rotation += _rot_dir * rot_speed * delta
	
	move_and_slide()
