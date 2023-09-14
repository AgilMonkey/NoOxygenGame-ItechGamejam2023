extends RigidBody2D

# Stat var
var health := 10
var oxygen := 200

# Movement var
var speed := 300.0
var max_speed := 400.0
var rot_speed := 200
var max_torq := 2000.0

var _input_dir := Vector2.ZERO
var _rot_dir := 0

signal on_health_changed(cur_health: int)
signal on_oxygen_changed(cur_oxygen: int)


func _ready() -> void:
	on_health_changed.emit(health) # Dianu biar ui berubah


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


func damage(amount: int):
	health -= amount
	health = clamp(health, 0, 10)
	on_health_changed.emit(health)


func reduce_oxygen(amount: int):
	oxygen -= amount
	oxygen = clamp(oxygen, 0, 200)
	on_oxygen_changed.emit(oxygen)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("damaging"):
		damage(1)
	if body.is_in_group("oxygen"):
		reduce_oxygen(-50)
		body.queue_free()


func _on_oxygen_timer_timeout() -> void:
	if oxygen <= 0:
		if $OutOfOxygenTimer.is_stopped():
			$OutOfOxygenTimer.start()
	reduce_oxygen(1)


func _on_out_of_oxygen_timer_timeout() -> void:
	if oxygen <= 0:
		damage(1)
