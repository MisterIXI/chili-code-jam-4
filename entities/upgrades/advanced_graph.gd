extends Upgrade
class_name Upgrade_Advanced_Graph

func apply_upgrade():
    
    GameData.current_upgrades["advanced_graphs"] = 1
    print(upgrade_level_valid())
    
func get_effect_value_text()  ->String:
    var _temp :String ="more Details"
    return  _temp