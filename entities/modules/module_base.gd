extends Node2D
class_name Module_Node

enum UPGRADE_TYPE {
	HEALTH  =0,
	SPEED  = 1,
	POWER = 2,
	ACCELERATION = 3
}
@export var upgrade : UPGRADE_TYPE = UPGRADE_TYPE.HEALTH
@export var upgrade_level : int = 0