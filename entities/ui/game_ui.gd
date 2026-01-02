extends CanvasLayer

const MAX_FOOD_INTERVAL : float = 1.1
signal game_started()
signal game_paused()
signal food_slider_changed(_value : float)

static var instance
# onready variables
@onready var _food_slider: HSlider = $HUD/Food_Slider_Margin/PanelContainer/VBoxContainer/MarginContainer/HSlider
@onready var _menu_panel : Control = $Menu
@onready var _hud_panel : Control = $HUD
@onready var _debug_panel :Control = $Debug

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_food_slider.value_changed.connect(_on_food_slider_changed)
	_food_slider.value = GameData.p_food_slider
	SoundManager.play_menu_music()

func _on_food_slider_changed(_value : float) ->void:
	food_slider_changed.emit(MAX_FOOD_INTERVAL -_value)
	

func on_fps_settings_changed(_value : bool) ->void:
	show_debug_panel(_value)

func show_debug_panel(_value : bool) ->void:
	if _value:
		_debug_panel.show()
	else:
		_debug_panel.hide()

func show_menu() ->void:
	SoundManager.play_menu_music()
	_hud_panel.hide()
	_menu_panel.show()
	print("GAME_UI: Switch to Menu")

func show_hud() ->void:
	SoundManager.play_game_music()
	_menu_panel.hide()
	_hud_panel.show()
	print("GAME_UI: Switch to HUD")

func pause_game() ->void:
	get_tree().paused = true
	show_menu()

