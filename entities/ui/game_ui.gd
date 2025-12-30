extends CanvasLayer
const MAX_FOOD_INTERVAL : float = 1.1
signal game_started()
signal game_paused()
signal food_slider_changed(_value : float)

@onready var _food_slider: HSlider = $HUD/Food_Slider_Margin/PanelContainer/VBoxContainer/MarginContainer/HSlider
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_food_slider.value_changed.connect(_on_food_slider_changed)

func _on_food_slider_changed(_value : float) ->void:
	food_slider_changed.emit(MAX_FOOD_INTERVAL -_value)