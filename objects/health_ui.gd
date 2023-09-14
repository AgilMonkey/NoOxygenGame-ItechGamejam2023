extends Label


func _on_astronot_on_health_changed(cur_health) -> void:
	text = "Health: " + str(cur_health)
