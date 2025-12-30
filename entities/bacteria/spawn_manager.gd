extends Node2D
class_name Spawn_Manager

const BACTERIA_SCENE = preload("res://entities/test/bubble.tscn")
const SMART_BACTERIA_SCENE = preload("res://entities/bacteria/smart_bacteria.tscn")
@export var real_spawn_curve: Curve
var max_bacteria : int = 500
var start_health : int = 10
var start_speed  : float = 100
var cooldown : float = 2.0
var max_food_eaten: int = 5
var fake_bacteria_count: float
var current_spawn_cap: float = 10_000

static var singleton

func _init():
	singleton = self
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# _new_bacteria(start_health * 10,start_speed*2,  global_position)
	_new_smart_bacteria(Vector2(0,0))
	max_bacteria = GameData.game_settings.get("max_bacterias")
	pass
	
func get_current_bacterias_count() -> float:
	return get_child_count() + fake_bacteria_count

func fake_spawn(count: float) -> void:
	var bac_count = get_current_bacterias_count()
	count = min(current_spawn_cap - bac_count, count)
	var real_spawn_percent: float = real_spawn_curve.sample(bac_count / max_bacteria)
	var real_spawn_count: int = floor(count * real_spawn_percent)
	fake_bacteria_count += count * (1.0 - real_spawn_percent)
	for i in range(real_spawn_count):
		_new_smart_bacteria((Vector2.RIGHT * randf() * 700).rotated(randf() * PI * 2))
	#TODO: Count spawn for stats


func instant_spawn(_pos : Vector2) ->void:
	var real_bac_count = get_child_count()
	if real_bac_count + fake_bacteria_count + 1 >= current_spawn_cap:
		# cancel spawn when this would exceed spawn cap
		return
	var is_real_spawn: bool = randf() < real_spawn_curve.sample(float(real_bac_count) / max_bacteria)
	if is_real_spawn:
		_new_smart_bacteria(_pos)
	else:
		fake_bacteria_count += 1.0

	# Use range(value) to iterate the requested number of times
	#for n in range(1):
	# _new_bacteria(start_health,start_speed, _pos)
	print("Bacteria#: ", get_child_count())
	#TODO: Count spawn for stats

func _new_bacteria(_start_health : int, _start_speed : float, _pos : Vector2) ->void:

	var _bacteria_scene : Bacteria= BACTERIA_SCENE.instantiate() as Bacteria
	add_child(_bacteria_scene)
	_bacteria_scene.global_position = _pos
	_bacteria_scene.setup(_start_health, _start_speed)
		# Defer add_child

func _new_smart_bacteria(pos: Vector2) -> void:
	var bacteria: SmartBacteria = SMART_BACTERIA_SCENE.instantiate()
	add_child(bacteria)
	bacteria.global_position = pos
	bacteria.health = start_health
