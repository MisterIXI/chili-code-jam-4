extends Upgrade
class_name Upgrade_Bacteria_Division_CDR

func apply_upgrade():
    if upgrade_level_valid():
        GameData.current_upgrades["bacteria_division_cdr"] += 1
        upgrade_level +=1
        upgrade_cost = upgrade_cost * upgrade_level
        upgrade_multiplier *=2
    

func get_effect_value_text()  ->String:
    var _temp :String ="Bacteria division rate increased:%d" % [upgrade_multiplier * upgrade_level]
    return  _temp