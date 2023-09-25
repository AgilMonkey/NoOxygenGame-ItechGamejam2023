extends Control

@onready var health_ui : ProgressBar = $Bars/HealthBar
@onready var oxygen_ui : ProgressBar = $Bars/OxygenBar
@onready var score_ui : Label = $ScoreUI

func _on_astronot_on_health_changed(cur_health) -> void:
	health_ui.value = cur_health
	health_ui.get_node("HealthLabel").text = "Health: " + str(cur_health)


func _on_astronot_on_oxygen_changed(cur_oxygen) -> void:
	oxygen_ui.value = cur_oxygen
	oxygen_ui.get_node("OxygenLabel").text = "Oxygen: " + str(cur_oxygen)


func _on_game_manager_on_score_changed(cur_score) -> void:
	score_ui.text = "SCORE\n" + str(cur_score)


func _on_astronot_on_death() -> void:
	visible = false
