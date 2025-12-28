extends Node2D

const bubble_scene = preload("res://entities/test/bubble.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_bubbles(500)

func spawn_bubbles(value : int ) ->void:
	for x in range(0,value):
		var _new = bubble_scene.instantiate()
		add_child(_new)
		_new.global_position = global_position