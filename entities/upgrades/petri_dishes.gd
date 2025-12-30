extends Upgrade
class_name Upgrade_Petri_Dishes

func apply_upgrade():
    GameData.current_upgrades["petri_dishes"] += 1
    upgrade_level +=1
    upgrade_cost = upgrade_cost * upgrade_level
    upgrade_multiplier *=2
    

func get_effect_value_text()  ->String:
    var _temp :String ="Petri dishes:%d" % [upgrade_multiplier * upgrade_level]
    return  _temp