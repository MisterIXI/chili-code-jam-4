extends Line2D

var max_width : float = 0.0
var max_height : float = 0.0

@export var dense : float = 60.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_width = get_parent().size.x
	max_height = get_parent().size.y
	_initialize_points()
	#connect at spawn_manager tick bacteria
func _initialize_points() ->void:
	var _temp_array : Array[Vector2]
	for x in range(dense):
		var _new_vector : Vector2 = Vector2(x * max_width/dense, randf_range(0.0,max_height))
		_temp_array.append(_new_vector)
	points = _temp_array

func _on_tick_bacteria(_value : float) ->void:
	points.remove_at(0)
	points.push_back(Vector2(dense * int(max_width/dense),int(max_height /_value)))

