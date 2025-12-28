extends Node2D
const FOOD_SCENE = preload("res://entities/food/food.tscn")
var base_food_value : int = 0
var base_food_spawntime : float = 0.5
var stat_food_cycles : int  = 0

@onready var timer : Timer = $Timer

func _ready() -> void:
    timer.timeout.connect(_on_timer_timeout)

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
    _instance.global_position = _pos
    ## spawn effect
    #set values
    _instance.food_amound = base_food_value * stat_food_cycles

   
