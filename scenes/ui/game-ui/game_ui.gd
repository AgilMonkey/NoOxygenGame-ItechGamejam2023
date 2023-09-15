extends Control

@onready var health_ui : Label = $HealthUI
@onready var oxygen_ui : Label = $OxygenUI

func _on_astronot_on_health_changed(cur_health) -> void:
	health_ui.text = "Health: " + str(cur_health)


func _on_astronot_on_oxygen_changed(cur_oxygen) -> void:
	oxygen_ui.text = "Oxygen: " + str(cur_oxygen)


func _on_astronot_on_death() -> void:
	visible = false
