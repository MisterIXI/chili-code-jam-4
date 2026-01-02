extends Upgrade
class_name Upgrade_Bacteria_Division_CDR

func apply_upgrade():
    if upgrade_level_valid():
        GameData.u_bacteria_division_cdr += 1
        upgrade_level +=1
        upgrade_cost = int(upgrade_cost_multiplier * upgrade_cost)
    
    

func get_effect_value_text()  ->String:
    var _temp :String ="division rate:%.3f s" % [-0.075 * upgrade_level + 2]
    return _temp