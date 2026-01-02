extends Upgrade
class_name Upgrade_Food_Drop_Max


func apply_upgrade():
    if upgrade_level_valid():
        GameData.u_food_drop_max += 1
        upgrade_level +=1
        upgrade_cost = int(upgrade_cost_multiplier * upgrade_cost)
    

func get_effect_value_text()  ->String:
    var _temp :String ="Food per second:%d" % [int(upgrade_multiplier* upgrade_level* GameData.p_food_slider)]
    return  _temp