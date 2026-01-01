@abstract
extends Resource
class_name Upgrade

## base settings name and description
@export var upgrade_name :String ="Default"
@export var upgrade_description : String ="This Upgrade can do really nice stuff"
@export var upgrade_texture : Texture2D
## current data while ingame
@export var upgrade_level : int = 0
@export var upgrade_max_level : int = 0
@export var upgrade_cost : int = 0
## multiplier on next level
@export var upgrade_multiplier : float = 0.05
@export var upgrade_cost_multiplier : float = 1.5
@abstract
func apply_upgrade()

@abstract
func get_effect_value_text()

func upgrade_loaded_data(_level : int)->void:
    for x in _level:
        apply_upgrade()

func upgrade_level_valid() ->bool:

    if upgrade_level >= upgrade_max_level:
        print("Upgrade: Error Max level reached, initial Sold out")
        UpgradeManager.on_upgrade_reached_max(self)
        return false
    else:
        return true