extends HSlider

var _time : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _physics_process(delta: float) -> void:
	if _time > 0:
		_time -= delta
		value = _time
func effect_start() ->void:
	_time = 1.5