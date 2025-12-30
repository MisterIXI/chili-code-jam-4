extends Node2D
const FOOD_SCENE = preload("res://entities/food/food.tscn")
var base_food_value : int = 0
var base_food_spawntime : float = 0.5
var stat_food_cycles : int  = 0
var offset : Vector2 = Vector2( 50,50)
#privates
var _game_ui_node : CanvasLayer
@onready var timer : Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	_game_ui_node = get_tree().get_first_node_in_group("game_ui")
	print("_game_ui:", _game_ui_node)
	if _game_ui_node:
		_game_ui_node.food_slider_changed.connect(_on_food_interval_change)
	else:
		print("Food_Manager: Error did not find a Game_UI")


func _on_timer_timeout() ->void:
	next_cycle()

func next_cycle() ->void:
	# get camera
	spawn(Vector2(randi_range(-960,960), randi_range(-540,540)))
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
