extends Upgrade
class_name Upgrade_Basic_Graphs

func apply_upgrade():
    if upgrade_level_valid():
        GameData.current_upgrades["basic_graphs"] += 1
        upgrade_level +=1
        upgrade_cost = upgrade_cost * upgrade_level
        upgrade_multiplier *=2
    

func get_effect_value_text()  ->String:
    var _temp :String ="Enabled Population Graph"
    return  _temp