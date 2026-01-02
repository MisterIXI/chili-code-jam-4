extends CanvasLayer

const MAX_FOOD_INTERVAL : float = 1.1

signal food_slider_changed(_value : float)

# onready variables
@onready var _food_slider: HSlider = $HUD/Food_Slider_Margin/PanelContainer/VBoxContainer/MarginContainer/HSlider
@onready var _menu_panel : Control = $Menu
@onready var _hud_panel : Control = $HUD
@onready var _debug_panel :Control = $Debug

## Color rect
@onready var _color_rect_menu : ColorRect = $Menu/ColorRect
## Public Vars
var start_game_time : int = 0
var _is_menu_enabled : bool = true
var _is_game_started :bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_food_slider.value_changed.connect(_on_food_slider_changed)
	_food_slider.value = GameData.p_food_slider
	SoundManager.play_menu_music()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu") and!_is_menu_enabled:
		pause_game()
	elif event.is_action_pressed("menu") and _is_menu_enabled:
		resume_game()


func _on_food_slider_changed(_value : float) ->void:
	GameData.p_food_slider = _value
	food_slider_changed.emit(_value)

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
	_is_menu_enabled = true

func show_hud() ->void:
	SoundManager.play_game_music()
	_menu_panel.hide()
	_hud_panel.show()
	print("GAME_UI: Switch to HUD")
	_is_menu_enabled = false

func pause_game() ->void:
	show_menu()

func resume_game() ->void:
	show_hud()
func start_game() ->void:
	_color_rect_menu.show()
	_is_game_started =true
	_is_menu_enabled = false
	show_hud()
	start_game_time = Time.get_ticks_msec()