extends Node

## To anyone that somehow reading this
## This is just a quick and a sorry excuse implementation of a dialogue system
## I am sorry

@export_multiline var dialogue : Array[String] = [
	"Hey you! Yeah you hold on there!",
	"Who the hell are you ?",
	"What who !?",
	"Yeah who else dummy ?",
	"How do you breathe in space ?",
	"Don't answer a question with another question...",
	"Anyway you're not supposed to be here",
	"Fuck you",
	"Ok then... we'll do this the hard way"
	]

@export_multiline var final_dialogue : Array[String] = [
	"Welp, i'm bored.",
	"Have you calmed down now ?",
	"Yeah.",
	"Cool i gtg",
	"Ok bye lol"
	]

@export var grayed_col : Color = Color.GRAY
var norm_col : Color = Color.WHITE
var invi_col : Color = Color(0, 0, 0, 0)
var is_type_finished := true
var char1_name = "You"
var char2_name = "Sintia Jaga"

signal dialogueing(text : String)
signal continuing_dialogue
signal dialogue_started
signal dialogue_ended

signal game_over_dialogue

@onready var dialogue_ui : DialogueUI = get_node("../UI/DialogueUI")
@onready var camera : Camera2D = get_node("../Camera2D")
@onready var boss_state : AnimationTree = get_node("../BossStateTree")
@export var boss_cam_pos : Node2D


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("skip_dialogue"):
		if not is_type_finished:
			dialogue_ui.skip_typing()
		else:
			continuing_dialogue.emit()


func start_dialogue() -> void:
	dialogue_started.emit()
	dialogue_ui.visible = true
	
	await change_dialogue_ui("", dialogue[0], null, null, grayed_col, invi_col)
	var old_cam_target = camera.target
	var old_cam_lerp_speed = camera.lerp_speed
	camera.lerp_speed = 2
	camera.target = boss_cam_pos
	boss_state["parameters/conditions/start"] = true
	dialogue_ui.character2.frame = 5
	await change_dialogue_ui(char2_name, dialogue[1], null, null, grayed_col, norm_col)
	await change_dialogue_ui(char1_name, dialogue[2], null, null, norm_col, grayed_col)
	await change_dialogue_ui(char1_name, dialogue[3], null, null, norm_col, grayed_col)
	dialogue_ui.character2.frame = 0
	await change_dialogue_ui(char2_name, dialogue[4], null, null, grayed_col, norm_col)
	await change_dialogue_ui(char2_name, dialogue[5], null, null, grayed_col, norm_col)
	await change_dialogue_ui(char1_name, dialogue[6], null, null, norm_col, grayed_col)
	dialogue_ui.character2.frame = 6
	await change_dialogue_ui(char2_name, dialogue[7], null, null, grayed_col, norm_col)
	boss_state["parameters/conditions/start_battle"] = true
	
	camera.target = old_cam_target
	camera.lerp_speed = old_cam_lerp_speed
	end_dialogue()

func final_dialouge():
	dialogue_started.emit()
	dialogue_ui.visible = true
	
	dialogue_ui.character2.frame = 7
	await change_dialogue_ui(char2_name, final_dialogue[0], null, null, grayed_col, norm_col)
	await change_dialogue_ui(char1_name, final_dialogue[1], null, null, norm_col, grayed_col)
	await change_dialogue_ui(char2_name, final_dialogue[2], null, null, grayed_col, norm_col)
	await change_dialogue_ui(char2_name, final_dialogue[3], null, null, grayed_col, norm_col)
	await change_dialogue_ui(char1_name, final_dialogue[4], null, null, norm_col, grayed_col)
	await change_dialogue_ui(char2_name, final_dialogue[5], null, null, grayed_col, norm_col)
	await change_dialogue_ui(char1_name, final_dialogue[6], null, null, norm_col, grayed_col)
	
	game_over_dialogue.emit()

func change_dialogue_ui(name, text, c1=null, c2=null, c1_col=norm_col, c2_col=norm_col):
	dialogue_ui.character_name = name
	if not c1 == null:
		dialogue_ui.character1 = c1
	if not c2 == null:
		dialogue_ui.character2 = c2
	dialogue_ui.character1.modulate = c1_col
	dialogue_ui.character2.modulate = c2_col
	dialogueing.emit(text)
	is_type_finished = false
	await wait_continue_dialogue()

func wait_continue_dialogue():
	await dialogue_ui.one_dialogue_finished
	is_type_finished = true
	await continuing_dialogue

func end_dialogue():
	dialogue_ui.visible = false
	dialogue_ended.emit()
