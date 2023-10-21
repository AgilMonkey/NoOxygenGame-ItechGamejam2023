extends Node2D

@export var ta : Array[PackedScene]

func _ready():
	print("Start")
	await test_awat()
	print("End")

func test_awat():
	await get_tree().create_timer(1.0).timeout
	print("HI")
	await get_tree().create_timer(1.0).timeout
	print("MOM")
