extends Node2D


@onready var main_menu_ui = preload("res://scenes/ui/menu.tscn")


func _on_trigger_boss_body_entered(body: Node2D) -> void:
	$TriggerBoss.queue_free()
	$BossDialogue.start_dialogue()


func quit_to_menu():
	get_tree().change_scene_to_packed(main_menu_ui)


func _on_astronot_on_death() -> void:
	quit_to_menu()
