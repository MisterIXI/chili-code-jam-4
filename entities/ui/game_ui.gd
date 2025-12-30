extends CanvasLayer
const MAX_FOOD_INTERVAL : float = 1.1
signal game_started()
signal game_paused()
signal food_slider_changed(_value : float)

# onready variables
@onready var _food_slider: HSlider = $HUD/Food_Slider_Margin/PanelContainer/VBoxContainer/MarginContainer/HSlider
@onready var _menu_panel : Control = $Menu
@onready var _hud_panel : Control = $HUD
@onready var _debug_panel :Control = $Debug

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_food_slider.value_changed.connect(_on_food_slider_changed)

func _on_food_slider_changed(_value : float) ->void:
	food_slider_changed.emit(MAX_FOOD_INTERVAL -_value)

func _on_fps_settings_changed(_value : bool) ->void:
	if _value:
		#show fps counter
		print("show fps")
	else:
		# hide fps counter
		print("hide fps")

func show_debug_panel(_value : bool) ->void:
	if _value:
		_debug_panel.show()
	else:
		_debug_panel.hide()

func show_menu() ->void:
	_hud_panel.hide()
	_menu_panel.show()
	print("GAME_UI: Switch to Menu")

func show_hud() ->void:
	_menu_panel.hide()
	_hud_panel.show()
	print("GAME_UI: Switch to HUD")

func pause_game() ->void:
	get_tree().paused = true
	show_menu()
