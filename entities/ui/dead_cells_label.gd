extends Label

@export var _slider : HSlider
# Called when the node enters the scene tree for the first time.

const BASE_TIME : float = 1.0
var _temptimer :float = 0.0
var _food_rotted : int = 0
var _is_visible : bool =false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visibility_changed.connect(_on_visible_changed)

func _on_visible_changed() ->void:
	_is_visible = true
	if !_is_visible:
		Spawn_Manager.singleton.food_rotted.connect(_add_rotten_foods)

func _add_rotten_foods(_value: int) ->void:
	_food_rotted += _value


func _physics_process(delta: float) -> void:
	_temptimer += delta
	if _temptimer >= BASE_TIME:
		_set_dead_cells_text()
		_temptimer = 0.0
func _set_dead_cells_text() ->void:
	var _new_text : String = str(_food_rotted)
	if _new_text != text:
		_slider.effect_start()
		text = str(_new_text)