extends Node
signal upgrade_leveled(_upgrade :Upgrade)

@export var upgrade_list : Array[Upgrade]

func on_upgrade_leveled(_upgrade:Upgrade) ->void:
    # upgrade level up
    upgrade_leveled.emit(_upgrade)