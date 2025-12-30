extends Control
### BUTTONS
@onready var _button_start : Button = $HBoxContainer/Button_Container/MarginContainer/VBoxContainer/Button_start
@onready var _button_settings :Button = $HBoxContainer/Button_Container/MarginContainer/VBoxContainer/Button_settings
@onready var _button_credits: Button = $HBoxContainer/Button_Container/MarginContainer/VBoxContainer/Button_credits
@onready var _button_quit :Button = $HBoxContainer/Button_Container/MarginContainer/VBoxContainer/Button_quit
### PANELS
@onready var _settings_panel : PanelContainer = $HBoxContainer/Settings_Container
@onready var _credits_panel : PanelContainer = $HBoxContainer/Credits_Container
#
### Settings Sliders
@onready var _master_volume_slider : HSlider =$HBoxContainer/Settings_Container/VBoxContainer/AudioContainer/VBoxContainer/MasterContainer/VBoxContainer/Margin_C/master_HSlider
@onready var _music_volume_slider : HSlider =$HBoxContainer/Settings_Container/VBoxContainer/AudioContainer/VBoxContainer/MusicContainer/VBoxContainer/Margin_C/music_HSlider
@onready var _sound_volume_slider :HSlider =$HBoxContainer/Settings_Container/VBoxContainer/AudioContainer/VBoxContainer/SoundContainer/VBoxContainer/Margin_C/sound_HSlider
### Video Settins
@onready var _fullscreen_checkbutton : CheckButton =$HBoxContainer/Settings_Container/VBoxContainer/VideoContainer/VBoxContainer/FullScreenContainer/Fullscreen_CheckButton
@onready var _fps_checkbutton : CheckButton =$HBoxContainer/Settings_Container/VBoxContainer/VideoContainer/VBoxContainer/FPS_Counter_Container/Fps_CheckButton
@onready var _max_bacteria_spawn : HSlider =$HBoxContainer/Settings_Container/VBoxContainer/VideoContainer/VBoxContainer/MaxSpawnsContainer/VBoxContainer/Margin_C/HSlider
@onready var _max_bacteria_value : Label = $HBoxContainer/Settings_Container/VBoxContainer/VideoContainer/VBoxContainer/MaxSpawnsContainer/VBoxContainer/HBoxContainer/max_spawn_value
### Persistent data
@onready var _save_data_checkbutton : CheckButton =$HBoxContainer/Settings_Container/VBoxContainer/PersistentContainer/VBoxContainer/Save_Data_Container/CheckButton
@onready var _save_game_interval : HSlider =$HBoxContainer/Settings_Container/VBoxContainer/PersistentContainer/VBoxContainer/MaxSpawnsContainer/VBoxContainer/Margin_C/HSlider
@onready var _save_game_interval_label : Label = $HBoxContainer/Settings_Container/VBoxContainer/PersistentContainer/VBoxContainer/MaxSpawnsContainer/VBoxContainer/HBoxContainer/save_interval_value
@onready var _button_clear : Button  =$HBoxContainer/Settings_Container/VBoxContainer/PersistentContainer/VBoxContainer/Clear_Data_Container2/Clear_Button
@onready var _button_delete : Button = $HBoxContainer/Settings_Container/VBoxContainer/PersistentContainer/VBoxContainer/Clear_Data_Container2/Delete_Button
@onready var _delete_timer : Timer =$delete_Timer
#private variables
var _menu_settings_toggle : bool = false
var _menu_credits_toggle :bool = false


func _ready() -> void:
	_button_start.pressed.connect(_on_button_start)
	_button_settings.pressed.connect(_on_button_settings)
	_button_credits.pressed.connect(_on_button_credits)
	_button_quit.pressed.connect(_on_button_quit)
	# menu settings connects
	_master_volume_slider.value_changed.connect(_on_master_volume_slider_changed)
	_music_volume_slider.value_changed.connect(_on_music_volume_slider_changed)
	_sound_volume_slider.value_changed.connect(_on_sound_volume_slider_changed)
	## SET VOLUME SLIDER TO SAVE DATA
	_master_volume_slider.value = GameData.game_settings["master_volume"]
	_music_volume_slider.value= GameData.game_settings ["music_volume"]
	_sound_volume_slider.value = GameData.game_settings ["sound_volume"]

	_fullscreen_checkbutton.toggled.connect(_on_toggled_fullscreen)
	_fps_checkbutton.toggled.connect(_on_toggled_fps_counter)
	_max_bacteria_spawn.value_changed.connect(_on_max_bacteria_slider_changed)
	_max_bacteria_spawn.value = float(GameData.game_settings["max_bacterias"])
	_max_bacteria_value.text = str(GameData.game_settings["max_bacterias"])
	#menu persistent data
	_save_data_checkbutton.toggled.connect(_on_save_data_changed)
	_save_game_interval.value_changed.connect(_on_save_game_interval_changed)
	_save_game_interval.value = float(GameData.game_settings["save_interval"])
	_save_game_interval_label.text  =str(GameData.game_settings["save_interval"])
	PersistentManager.on_timer_waittime_changed(float(GameData.game_settings["save_interval"]))

	_button_clear.pressed.connect(_on_button_clear_pressed)
	_button_delete.pressed.connect(_on_button_delete_pressed)
	_delete_timer.timeout.connect(_on_delete_timer_reset)

#### MENU BUTTON FUNCTIONS ####
func _on_button_start() ->void:
	print("Start Game")
	_button_start.text = "Resume"
	get_parent().show_hud()
	get_tree().change_scene_to_file(GameData.GAME_SCENE)


func _on_button_settings() ->void:
	_menu_settings_toggle = ! _menu_settings_toggle
	if _menu_settings_toggle:
		_menu_credits_toggle = false
		_settings_panel.show()
		_credits_panel.hide()
	else:
		_settings_panel.hide()

func _on_button_credits() ->void:
	_menu_credits_toggle = ! _menu_credits_toggle
	if _menu_credits_toggle:
		_menu_settings_toggle =false
		_credits_panel.show()
		_settings_panel.hide()
	else:
		_credits_panel.hide()

func _on_button_quit() ->void:
	# GAME SAVE 
	PersistentManager.save_game_data()
	get_tree().quit()

#### MENU SETTINGS FUNCTIONS ####
func _on_toggled_fullscreen(_value : bool) ->void:
	if _value:
		GameData.game_settings["fullscreen"] =  1
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		GameData.game_settings["fullscreen"] =  0
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 

func _on_toggled_fps_counter(_value :bool) ->void:
	if _value:
		GameData.game_settings["fps_counter"]  =1
		get_parent().on_fps_settings_changed(true)
	else:
		GameData.game_settings["fps_counter"]  =0
		get_parent().on_fps_settings_changed(false)

func _on_max_bacteria_slider_changed(_value :float) ->void:
	GameData.game_settings["max_bacterias"] = int(_value)
	print("Menu_Settings: Max Bacterias have changed to:", GameData.game_settings["max_bacterias"])
	_max_bacteria_value.text = str(GameData.game_settings["max_bacterias"])

func _on_save_data_changed(_value: bool) ->void:
	if _value:

		GameData.game_settings["save_game_data"] = 1
	else:
		GameData.game_settings["save_game_data"] = 0

	print("Menu_Settings: Game data saves: ", _value)

func _on_save_game_interval_changed(_value : float) ->void:
	GameData.game_settings["save_interval"] = int (_value)
	print("Menu_Settings: Max Bacterias have changed to:", GameData.game_settings["max_bacterias"])
	_save_game_interval_label.text  =str(GameData.game_settings["save_interval"])
	PersistentManager.on_timer_waittime_changed(float(GameData.game_settings["save_interval"]))

func _on_button_clear_pressed()->void:
	print("Menu_Settings: Clear button pressed -> delete button show")
	_button_clear.hide()
	_button_delete.show()
	_delete_timer.start()

func _on_button_delete_pressed() ->void:
	print("Menu_Settings: Game_Data deleted")
	PersistentManager.delete_game_data()

	_button_delete.hide()
	_button_clear.show()

func _on_delete_timer_reset() ->void:
	_button_delete.hide()
	_button_clear.show()

func _on_master_volume_slider_changed(_value : float) ->void:
	SoundManager.set_volume(0, _value)
func _on_music_volume_slider_changed(_value : float) ->void:
	SoundManager.set_volume(1, _value)
func _on_sound_volume_slider_changed(_value : float) ->void:
	SoundManager.set_volume(2, _value)
