extends Area2D
class_name Bullet

var velocity : Vector2 = Vector2.ZERO
var ang_vel : float = 0
var clamp_rot = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = velocity.rotated(ang_vel * delta)
	translate(velocity * delta)


func _on_delete_timer_timeout() -> void:
	queue_free()
