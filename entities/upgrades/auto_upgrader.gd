extends Upgrade
class_name Upgrade_Auto_updater

func apply_upgrade():

    GameData.u_auto_upgrader = 1
    print(upgrade_level_valid())
    UpgradeManager.upgrade_purchased_auto_upgrader.emit()

func get_effect_value_text()  ->String:
    var _temp :String ="automatically"
    return  _temp