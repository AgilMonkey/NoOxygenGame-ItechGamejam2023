extends CanvasLayer

var main_scene : PackedScene = load("res://scenes/Main.tscn")
var extra_scene : PackedScene = load("res://scenes/world/extra_level.tscn")

func _on_start_pressed():
	get_tree().change_scene_to_packed(main_scene)


func _on_exit_pressed():
	get_tree().quit()


func _on_extra_level_button_pressed() -> void:
	get_tree().change_scene_to_packed(extra_scene)
