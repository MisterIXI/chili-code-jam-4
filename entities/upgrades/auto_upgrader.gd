extends Upgrade
class_name Upgrade_Auto_updater

func apply_upgrade():

    GameData.current_upgrades["auto_upgrader"] += 1
    upgrade_level +=1
    upgrade_cost = upgrade_cost * upgrade_level
    upgrade_multiplier *=2
    print(upgrade_level_valid())
    

func get_effect_value_text()  ->String:
    var _temp :String ="Auto-Upgrader will upgrade, when the cheapest upgrade is available"
    return  _temp