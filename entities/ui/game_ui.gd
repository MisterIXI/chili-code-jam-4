extends CanvasLayer
const MAX_FOOD_INTERVAL : float = 1.1
signal game_started()
signal game_paused()
signal food_slider_changed(_value : float)

#private variables
var _menu_settings_toggle : bool = false
var _menu_credits_toggle :bool = false
# onready variables

@onready var _menu_panel : Control = $Menu
@onready var _hud_panel : Control = $HUD
# menu panels
@onready var _menu_setting_panel : PanelContainer = $Menu/HBoxContainer/Settings_Container
@onready var _menu_credits_panel : PanelContainer = $Menu/HBoxContainer/Credits_Container
#buttons menu
@onready var _button_start : Button = $Menu/HBoxContainer/Button_Container/MarginContainer/VBoxContainer/Button_start
@onready var _button_settings : Button = $Menu/HBoxContainer/Button_Container/MarginContainer/VBoxContainer/Button_settings
@onready var _button_credits : Button = $Menu/HBoxContainer/Button_Container/MarginContainer/VBoxContainer/Button_credits
@onready var _button_quit : Button =$Menu/HBoxContainer/Button_Container/MarginContainer/VBoxContainer/Button_quit
### Settings Sliders
@onready var _master_volume_slider : HSlider =$Menu/HBoxContainer/Settings_Container/VBoxContainer/AudioContainer/VBoxContainer/MasterContainer/VBoxContainer/master_HSlider
@onready var _music_volume_slider : HSlider =$Menu/HBoxContainer/Settings_Container/VBoxContainer/AudioContainer/VBoxContainer/MusicContainer/VBoxContainer/music_HSlider
@onready var _sound_volume_slider :HSlider =$Menu/HBoxContainer/Settings_Container/VBoxContainer/AudioContainer/VBoxContainer/SoundContainer/VBoxContainer/sound_HSlider
### Video Settins
@onready var _fullscreen_checkbox : CheckBox =$Menu/HBoxContainer/Settings_Container/VBoxContainer/VideoContainer/VBoxContainer/FullScreenContainer/Fullscreen_CheckButton
@onready var _fps_checkbox : CheckBox =$Menu/HBoxContainer/Settings_Container/VBoxContainer/VideoContainer/VBoxContainer/FPS_Counter_Container/Fps_CheckButton

@onready var _food_slider: HSlider = $HUD/Food_Slider_Margin/PanelContainer/VBoxContainer/MarginContainer/HSlider
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_food_slider.value_changed.connect(_on_food_slider_changed)
	## button connects
	_button_start.pressed.connect(_on_pressed_button_start)
	_button_settings.pressed.connect(_on_pressed_menu_settings_toggle)
	_button_credits.pressed.connect(_on_pressed_menu_credits_toggle)
	_button_quit.pressed.connect(_on_pressed_button_quit)
	# menu settings connects
	_fullscreen_checkbox.toggled.connect(_on_toggled_fullscreen)
	_fps_checkbox.toggled.connect(_on_toggled_fps_counter)

func _on_food_slider_changed(_value : float) ->void:
	food_slider_changed.emit(MAX_FOOD_INTERVAL -_value)
#### MENU SETTINGS FUNCTIONS ####
func _on_toggled_fullscreen(_value : bool) ->void:
	if _value:
		GameData.game_settings["fullscreen"] =  1
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		GameData.game_settings["fullscreen"] =  0
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 

func _on_toggled_fps_counter(_value :bool) ->void:
	pass
#### MENU BUTTON FUNCTIONS ####
func _on_pressed_button_start() ->void:
	print("Start Game")
	get_tree().change_scene_to_file(GameData.GAME_SCENE)

func _on_pressed_menu_settings_toggle() ->void:
	_menu_settings_toggle = ! _menu_settings_toggle
	if _menu_settings_toggle:
		_menu_setting_panel.show()
		_menu_credits_panel.hide()
	else:
		_menu_setting_panel.hide()

func _on_pressed_menu_credits_toggle() ->void:
	_menu_credits_toggle = ! _menu_credits_toggle
	if _menu_credits_toggle:
		_menu_credits_panel.show()
		_menu_setting_panel.hide()
	else:
		_menu_credits_panel.hide()

func _on_pressed_button_quit() ->void:
	# GAME SAVE 
	PersistentManager.save_game_data()
	get_tree().quit()
