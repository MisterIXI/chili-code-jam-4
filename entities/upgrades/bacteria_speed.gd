extends Upgrade
class_name Upgrade_Bacteria_Speed

func apply_upgrade():
    if upgrade_level <= 50:
        GameData.current_upgrades["bacteria_speed"] += 1
        upgrade_level +=1
        upgrade_cost = upgrade_cost * upgrade_level
    else:
        # UPGRADE MAXED
        print("Upgrade reached maxed level")
    

func get_effect_value_text()  ->String:
    var _temp :String ="Bacteria Speed Increased: +%d %" % [upgrade_multiplier * upgrade_level]
    return  _temp