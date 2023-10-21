extends Control
class_name DialogueUI

var character_name : String:
	get:
		return label_name.text
	set(value):
		label_name.text = value

var full_text : String = ""
var text_index : int = 0 

@export var normal_text_speed := 0.02
@export var exclamation_speed := 0.5
@export var period_speed := 0.5

signal one_dialogue_finished

@onready var label := $Box/DialogueText
@onready var label_name : Label = $Name
@onready var character1 := $Character1
@onready var character2 : Sprite2D = $Character2
@onready var letter_timer := $LetterTimer


func display_text(text):
	label.text = ""
	full_text = text
	text_index = 0
	display_letter()

func display_letter():
	if text_index >= len(full_text):
		one_dialogue_finished.emit()
		return
	label.text += full_text[text_index]
	match full_text[text_index]:
		'.':
			letter_timer.start(period_speed)
		'!':
			letter_timer.start(exclamation_speed)
		_:
			letter_timer.start(normal_text_speed)
	text_index += 1


func skip_typing():
	letter_timer.stop()
	label.text = full_text
	text_index = len(full_text) - 1
	one_dialogue_finished.emit()


func _on_letter_timer_timeout() -> void:
	display_letter()
