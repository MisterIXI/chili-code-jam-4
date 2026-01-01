extends Upgrade
class_name Upgrade_Auto_updater

func apply_upgrade():

    GameData.current_upgrades["auto_upgrader"] = 1
    print(upgrade_level_valid())
    

func get_effect_value_text()  ->String:
    var _temp :String ="The cheapest will buy automatically"
    return  _temp