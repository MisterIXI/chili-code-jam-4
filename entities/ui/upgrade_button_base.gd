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

@export var upgrade : Upgrade
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpgradeManager.upgrade_leveled.connect(_on_upgrade_leveled)
	upgrade_texture.texture = upgrade.upgrade_texture
	upgrade_name.text = upgrade.upgrade_name
	upgrade_tooltip.tooltip_text = upgrade.upgrade_description

func _set_data(_upgrade : Upgrade) ->void:
	upgrade_level.text = str(_upgrade.upgrade_level)
	upgrade_effect_value.text = str(_upgrade.get_effect_value_text())
	upgrade_cost.text = str(_upgrade.upgrade_cost)


func _on_upgrade_leveled(_upgrade: Upgrade) ->void:
	if _upgrade.upgrade_name == upgrade.upgrade_name:
		_set_data(_upgrade)