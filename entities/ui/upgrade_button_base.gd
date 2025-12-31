extends MarginContainer
const STRING_LEVEL : String = "Level: "
const STRING_COST : String = "Cost: "

@onready var upgrade_texture : TextureRect = $PanelContainer/HBoxContainer/MarginContainer/TextureRect
@onready var upgrade_name : Label =  $PanelContainer/HBoxContainer/VBoxContainer/upgrade_name
@onready var upgrade_level : Label = $PanelContainer/HBoxContainer/VBoxContainer/Level_value
@onready var upgrade_effect_value : Label = $PanelContainer/HBoxContainer/VBoxContainer/effect_value
@onready var upgrade_cost : Label = $PanelContainer/HBoxContainer/VBoxContainer/HBoxContainer/upgrade_cost
## tooltip
@onready var upgrade_tooltip : PanelContainer =$PanelContainer
#### Get data: 
@export var upgrade_string : String =""
@export var is_one_time_upgrade :bool = false
#private variables 
var is_enabled : bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpgradeManager.update_visual_upgrade.connect(_on_upgrade_leveled)
	UpgradeManager.upgrade_reached_max.connect(_on_upgrade_reached_max)

func _set_data(_upgrade : Upgrade) ->void:
	upgrade_level.text = str(_upgrade.upgrade_level)
	upgrade_effect_value.text = str(_upgrade.get_effect_value_text())
	upgrade_cost.text = str(_upgrade.upgrade_cost)
	upgrade_texture.texture = _upgrade.upgrade_texture
	upgrade_name.text = _upgrade.upgrade_name
	upgrade_tooltip.tooltip_text = _upgrade.upgrade_description

func _on_upgrade_reached_max(_upgrade : Upgrade) ->void:
	if upgrade_string == _upgrade.upgrade_name:
		upgrade_level.text = str(_upgrade.upgrade_level)
		upgrade_effect_value.text = str(_upgrade.get_effect_value_text())
		upgrade_cost.text = "Sold Out"
		upgrade_texture.texture = _upgrade.upgrade_texture
		upgrade_name.text = _upgrade.upgrade_name
		upgrade_tooltip.tooltip_text = _upgrade.upgrade_description + " You reached max level."
		is_enabled = false

func _on_upgrade_leveled(_upgrade: Upgrade) ->void:
	if upgrade_string == _upgrade.upgrade_name:
		_set_data(_upgrade)


func _on_gui_input(_event: InputEvent) -> void:
	if _event is InputEventMouseButton and (_event.button_index == MOUSE_BUTTON_LEFT or _event.button_index == MOUSE_BUTTON_RIGHT):
		if _event.is_pressed():
			UpgradeManager.on_upgrade_clicked(upgrade_string)


func _on_mouse_exited() -> void:
	pass # Replace with function body.

func _on_mouse_entered() -> void:
	pass # Replace with function body.
