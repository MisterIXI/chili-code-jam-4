extends Node
## signal if upgrade reached max - > visuals will change to SOLD OUT
signal upgrade_reached_max(_upgrade : Upgrade)
## signal for buttons if upgrade.apply_upgrade
signal update_visual_upgrade(_upgrade : Upgrade)

########################################
## Current Upgrade_list
@export var upgrade_list : Array[Upgrade]
#########################################

## functions for buttons 
func _level_upgrade(_upgrade:Upgrade) ->void:
    # upgrade level up
    _upgrade.apply_upgrade()
    ## update visuals
    update_visual_upgrade.emit(_upgrade)


## functions for apply_upgrade if upgraded reached max level
func on_upgrade_reached_max(_upgrade : Upgrade) ->void:
    upgrade_reached_max.emit(_upgrade)


## this function will store game data after restarts
func on_upgrade_game_data_loaded(_level : int,_upgrade : Upgrade) ->void:
    ## upgradelevel to database
    for x in upgrade_list:
        if x.upgrade_name == _upgrade.upgrade_name:
            for y in _level:
                x.apply_upgrade()
    ## update visuals
    update_visual_upgrade.emit(_upgrade)
### ON BUTTON PRESSED
func on_upgrade_clicked(upgrade_string :String) ->void:
    for x in upgrade_list:
        if x.upgrade_name == upgrade_string:
            _level_upgrade(x)
