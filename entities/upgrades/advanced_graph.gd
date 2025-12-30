extends Upgrade
class_name Upgrade_Advanced_Graph

func apply_upgrade():
    GameData.current_upgrades["advanced_graphs"] += 1
    upgrade_level +=1
    upgrade_cost = upgrade_cost * upgrade_level
    upgrade_multiplier *=2
    

func get_effect_value_text()  ->String:
    var _temp :String ="Advanced Graph shows more Details"
    return  _temp