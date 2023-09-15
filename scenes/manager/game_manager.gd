extends Node

var score := 0

signal on_score_changed(cur_score)

func _on_score_timer_timeout() -> void:
	score += 1
	on_score_changed.emit(score)
