extends Upgrade
class_name Upgrade_Basic_Graphs

func apply_upgrade():
    GameData.u_basic_graphs= 1
    print(upgrade_level_valid())


func get_effect_value_text()  ->String:
    var _temp :String ="Enabled Population Graph"
    return  _temp