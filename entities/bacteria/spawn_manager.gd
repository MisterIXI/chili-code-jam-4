extends Node2D
class_name Spawn_Manager

const BACTERIA_SCENE = preload("res://entities/test/bubble.tscn")
var stat_spawned_bacterias : int =  1

var start_health : int = 10
var start_speed  : float = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_new_bacteria(start_health * 10,start_speed*2,  global_position)
	
func get_current_bacterias_count() -> int:
	return get_child_count()

func spawn(_pos : Vector2) ->void:
	# Use range(value) to iterate the requested number of times
	#for n in range(1):
	_new_bacteria(start_health,start_speed, _pos)

func _new_bacteria(_start_health : int, _start_speed : float, _pos : Vector2) ->void:

	var _bacteria_scene : Bacteria= BACTERIA_SCENE.instantiate() as Bacteria
	add_child(_bacteria_scene)
	_bacteria_scene.global_position = _pos
	_bacteria_scene.setup(_start_health, _start_speed)
	stat_spawned_bacterias += 1
		# Defer add_child
