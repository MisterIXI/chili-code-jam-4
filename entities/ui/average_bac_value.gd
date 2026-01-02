extends Label
@export var graph_data : Line2D
@export var _slider : HSlider
const AVERAGE_SYMBOL :String = "Ø "
const BASE_TIME : float = 1.0
var _temptimer :float = 0.0
var _is_enabled: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visibility_changed.connect(_on_visible_changed)

func _on_visible_changed() ->void:
	_is_enabled = true

func _physics_process(delta: float) -> void:
	if !_is_enabled:
		return
	_temptimer += delta
	if _temptimer >= BASE_TIME:
		_set_average_text_value()
		_temptimer = 0.0

func _set_average_text_value() ->void:

	var _temp_value : float = 0
	for x in graph_data.stored_values:
		_temp_value += x
	_temp_value = _temp_value / graph_data.stored_values.size()
	if text != AVERAGE_SYMBOL + str(_temp_value):
		_slider.effect_start()
		text = AVERAGE_SYMBOL + str(_temp_value)
