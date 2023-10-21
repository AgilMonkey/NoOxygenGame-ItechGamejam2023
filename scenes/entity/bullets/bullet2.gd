extends Bullet

@onready var sprite = $Bullet

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	sprite.rotation = velocity.angle()
