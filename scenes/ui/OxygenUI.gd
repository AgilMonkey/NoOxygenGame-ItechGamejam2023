extends Label


func _on_astronot_on_oxygen_changed(cur_oxygen) -> void:
	text = "Oxygen: " + str(cur_oxygen)
