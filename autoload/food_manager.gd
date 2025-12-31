class_name FoodManager
extends Node2D
const FOOD_SCENE = preload("res://entities/food/food.tscn")
var base_food_value : int = 0
var base_food_spawntime : float = 0.5
var stat_food_cycles : int  = 0
var offset : Vector2 = Vector2( 50,50)
#privates
const FOOD_MULT: int = 3
@onready var timer : Timer = $Timer
var food_cd: float = 0.5
var food_per_sec: float = 10

func get_food_rate() -> float:
	return timer.wait_time * FOOD_MULT

func _ready() -> void:
	# timer.timeout.connect(_on_timer_timeout)

	GameUi.food_slider_changed.connect(_on_food_interval_change)
	GameUi._food_slider.min_value = 0
	GameUi._food_slider.max_value = 100
	GameUi._food_slider.value = 10

func _on_timer_timeout() ->void:
	next_cycle()

func next_cycle() ->void:
	# get camera
	for x in range(FOOD_MULT):
		spawn((Vector2.RIGHT * randf() * 850).rotated(randf() * PI * 2))
	# stat up
	stat_food_cycles += 1

func spawn(_pos : Vector2) ->void:

	var _instance  = FOOD_SCENE.instantiate()
	add_child(_instance)
	_instance.global_position = _pos + offset
	#set values
	_instance.food_amount = base_food_value * stat_food_cycles

   
func _on_food_interval_change(_value : float) ->void:
	if _value > 0:
		timer.wait_time = _value
		print("Food_Manager: feed interval changed to: ", _value)
		GameData.player_progress["food_slider"] = _value
