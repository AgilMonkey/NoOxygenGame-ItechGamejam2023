extends Control


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_exit_button_pressed() -> void:
	print("EXitt")


func _on_astronot_on_death() -> void:
	visible = true
