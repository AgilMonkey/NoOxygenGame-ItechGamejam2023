extends RigidBody2D

# Stat var
var health := 10

# Movement var
var speed := 300.0
var max_speed := 400.0
var rot_speed := 200
var max_torq := 2000.0

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
	if _input_dir.length_squared() > 0:
		apply_force(Vector2(0, _input_dir.y * speed).rotated(rotation))
	else:
		apply_force(Vector2.ZERO)

	linear_velocity = linear_velocity.limit_length(max_speed)
	angular_velocity = _rot_dir * rot_speed * delta
