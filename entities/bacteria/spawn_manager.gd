extends Node2D
class_name Spawn_Manager

const BACTERIA_SCENE = preload("res://entities/test/bubble.tscn")
const SMART_BACTERIA_SCENE = preload("res://entities/bacteria/smart_bacteria.tscn")
var stat_spawned_bacterias : int =  1

var start_health : int = 10
var start_speed  : float = 100
var cooldown : float = 2.0
var max_food_eaten: int = 5
static var singleton
func _init():
	singleton = self
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# _new_bacteria(start_health * 10,start_speed*2,  global_position)
	pass
	
func get_current_bacterias_count() -> int:
	return get_child_count()

func spawn(_pos : Vector2) ->void:
	# Use range(value) to iterate the requested number of times
	#for n in range(1):
	# _new_bacteria(start_health,start_speed, _pos)
	_new_smart_bacteria(_pos)
	print("Bacteria#: ", get_child_count())

func _new_bacteria(_start_health : int, _start_speed : float, _pos : Vector2) ->void:

	var _bacteria_scene : Bacteria= BACTERIA_SCENE.instantiate() as Bacteria
	add_child(_bacteria_scene)
	_bacteria_scene.global_position = _pos
	_bacteria_scene.setup(_start_health, _start_speed)
	stat_spawned_bacterias += 1
		# Defer add_child

func _new_smart_bacteria(pos: Vector2) -> void:
	var bacteria: SmartBacteria = SMART_BACTERIA_SCENE.instantiate()
	add_child(bacteria)
	bacteria.global_position = pos
	bacteria.health = start_health
