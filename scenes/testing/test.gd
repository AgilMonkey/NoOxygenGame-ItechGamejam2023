extends Node2D

@export var ta : Array[PackedScene]

func _ready():
	print(len(ta))

func _process(delta: float) -> void:
	print(len(ta))
