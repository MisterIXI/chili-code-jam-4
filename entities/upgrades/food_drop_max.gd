extends Upgrade
class_name Upgrade_Food_Drop_Max


func apply_upgrade():
    GameData.current_upgrades["food_drop_max"] += 1
    upgrade_level +=1
    upgrade_cost = upgrade_cost * upgrade_level
    upgrade_multiplier *=2
    

func get_effect_value_text()  ->String:
    var _temp :String ="Food per second:%d" % [upgrade_multiplier * GameData.player_progress["food_slider"]]
    return  _temp