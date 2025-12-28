extends Node2D
class_name Spawn_Manager

const BACTERIA_SCENE = preload("res://entities/test/bubble.tscn")
var stat_spawned_bacterias : int =  0

var _start_health : int = 100
var _start_speed  : float = 300
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn(1,global_position)
	
func get_current_bacterias_count() -> int:
	return get_child_count()

func spawn(value : int, _pos : Vector2) ->void:
	#if get_child_count(false) < 1000:
	for n in value:

		var _new = BACTERIA_SCENE.instantiate()
		_new.setup(_start_health, _start_speed)
		_new.global_position = _pos
		stat_spawned_bacterias += 1
		self.add_child(_new)
