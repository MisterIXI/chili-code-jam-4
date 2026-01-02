extends Line2D

var max_width : float = 0.0
var max_height : float = 0.0

## old bacteria
var _old_food_data : Array[float] = []
@export var dense : float = 60.0
@onready var _timer : Timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_width = get_parent().size.x
	max_height = get_parent().size.y

	_initialize_points()
	#connect at spawn_manager tick bacteria
	_timer.timeout.connect(_on_timer_timeout)

func _initialize_points() ->void:
	
	var _temp_array : Array[Vector2]
	for x in range(dense):
		var _new_vector : Vector2 = Vector2(x * max_width/dense, randf_range(0.0,max_height))
		_temp_array.append(_new_vector)
		_old_food_data.append(0)
	points = _temp_array

func _on_timer_timeout() ->void:
	if visible and Spawn_Manager.singleton:
		_on_tick_food(Spawn_Manager.singleton.get_current_foods())

func _on_tick_food(_value : float) ->void:
	#set old data
	_old_food_data.pop_front()
	_old_food_data.push_back(_value)

	var _max : float = _old_food_data.max()
	#create array
	var _array : Array[Vector2] =[]
	for x in range(_old_food_data.size()):

		_array.push_back(
			Vector2(
			x * (max_width / dense),
			max_height -(max(1,_old_food_data[x]) / _max * max_height)
		))
	
	points = PackedVector2Array(_array)
