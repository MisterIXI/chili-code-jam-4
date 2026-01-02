extends Upgrade
class_name Upgrade_Petri_Dishes

func apply_upgrade():
    if upgrade_level_valid():
        GameData.u_petri_dishes += 1
        upgrade_level +=1
        upgrade_cost = int(upgrade_cost_multiplier * upgrade_cost)
    

func get_effect_value_text()  ->String:
    var _temp :String ="Petri dishes:%d" % [int(upgrade_multiplier* upgrade_level)]
    return  _temp