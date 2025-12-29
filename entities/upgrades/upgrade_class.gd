@abstract
extends Resource
class_name Upgrade

## base settings name and description
@export var upgrade_name :String ="Default"
@export var upgrade_description : String ="This Upgrade can do really nice stuff"

## current data while ingame
@export var upgrade_level : int = 0
@export var upgrade_cost : int = 0

## Base variables
@export var upgrade_base_cost : int = 0
## multiplier on next level
@export var upgrade_multiplier : float = 0.05
@export var upgrade_cost_increase_multiplier : float = 1.05


@abstract
func apply_upgrade()

