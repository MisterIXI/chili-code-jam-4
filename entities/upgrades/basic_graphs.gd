extends Upgrade
class_name Upgrade_Basic_Graphs

func apply_upgrade():
    GameData.u_basic_graphs= 1
    print(upgrade_level_valid())
    UpgradeManager.upgrade_purchased_basic_graph.emit()


func get_effect_value_text()  ->String:
    var _temp :String ="Enabled Population Graph"
    return  _temp