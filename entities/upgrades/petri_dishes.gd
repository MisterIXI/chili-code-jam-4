extends Upgrade
class_name Upgrade_Petri_Dishes

func apply_upgrade():
    if upgrade_level_valid():
        GameData.current_upgrades["petri_dishes"] += 1
        upgrade_level +=1
        upgrade_cost = int(upgrade_cost_multiplier * upgrade_cost)
        upgrade_multiplier *= upgrade_level
    

func get_effect_value_text()  ->String:
    var _temp :String ="Petri dishes:%d" % [upgrade_multiplier * upgrade_level]
    return  _temp