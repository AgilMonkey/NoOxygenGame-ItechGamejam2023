extends Control


@export var menu_scene : PackedScene

@onready var score_ui := $Score
var cur_score := 0


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_packed(menu_scene)


func _on_astronot_on_death() -> void:
	visible = true
	score_ui.text = "SCORE\n" + str(cur_score)+ "\nHIGHSCORE\n" + str(GlobalManager.highscore)


func _on_game_manager_on_score_changed(_score) -> void:
	cur_score = _score
