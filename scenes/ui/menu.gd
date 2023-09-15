extends CanvasLayer

@export var main_scene : PackedScene 

func _on_start_pressed():
	get_tree().change_scene_to_packed(main_scene)


func _on_exit_pressed():
	get_tree().quit()
