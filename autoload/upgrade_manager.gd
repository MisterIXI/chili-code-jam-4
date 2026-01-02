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
    #if payable
    if _upgrade.upgrade_cost <= GameData.p_dna_currency:
        # PAY UPGRADE
        _pay_upgrade(_upgrade.upgrade_cost)
        # upgrade level up
        _upgrade.apply_upgrade()
        ## update visuals
        update_visual_upgrade.emit(_upgrade)
        print("Upgrade_Manager: Upgraded %s to level %d" %[_upgrade.upgrade_name, _upgrade.upgrade_level])
        SoundManager.play_click()
    else:
        print("Upgrade_Manager: Error you dont have enough Dna")
        SoundManager.play_error()
func _pay_upgrade(_upgrade_cost : int) ->void:
    GameData.p_dna_currency -= _upgrade_cost

## functions for apply_upgrade if upgraded reached max level
func on_upgrade_reached_max(_upgrade : Upgrade) ->void:
    upgrade_reached_max.emit(_upgrade)


## this function will store game data after restarts
func on_upgrade_game_data_loaded(_upgrade_string : String,_level : int) ->void:
    ## upgradelevel to database
    for x in upgrade_list:
        if x.upgrade_name == _upgrade_string:
            for y in _level:
                x.apply_upgrade()
            update_visual_upgrade.emit(x)
            ## update visuals
    
### ON BUTTON PRESSED
func on_upgrade_clicked(upgrade_string :String) ->void:
    for x in upgrade_list:
        if x.upgrade_name == upgrade_string:
            _level_upgrade(x)
