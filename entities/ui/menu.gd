extends Control
### BUTTONS
@onready var _button_start : Button = $HBoxContainer/Button_Container/MarginContainer/VBoxContainer/Button_start
@onready var _button_settings :Button = $HBoxContainer/Button_Container/MarginContainer/VBoxContainer/Button_settings
@onready var _button_credits: Button = $HBoxContainer/Button_Container/MarginContainer/VBoxContainer/Button_credits
@onready var _button_quit :Button = $HBoxContainer/Button_Container/MarginContainer/VBoxContainer/Button_quit
### PANELS
@onready var _settings_panel : PanelContainer = $HBoxContainer/Settings_Container
@onready var _credits_panel : PanelContainer = $HBoxContainer/Credits_Container

func _ready() -> void:
	_button_start.pressed.connect(_on_button_start)
	_button_settings.pressed.connect(_on_button_settings)
	_button_credits.pressed.connect(_on_button_credits)
	_button_quit.pressed.connect(_on_button_quit)


func _on_button_start() ->void:
	pass

func _on_button_settings() ->void:
	_settings_panel.show()
	_credits_panel.hide()

func _on_button_credits() ->void:
	_credits_panel.show()
	_settings_panel.hide()

func _on_button_quit() ->void:
	#SAVE GAME
	get_tree().quit()

func _on_button_clear_data() ->void:
	# Show DELETE BUTTON
	pass
func _on_button_delete_data() ->void:
	#delete
	pass