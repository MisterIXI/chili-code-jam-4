extends MarginContainer

@onready var _basic_graph_panel : PanelContainer = $Stat_Panel/VBoxContainer/Basic_Graph

@onready var _advanced_stat_01 : PanelContainer = $Stat_Panel/VBoxContainer/GridContainer/Adv_stat_01
@onready var _advanced_stat_02 : PanelContainer = $Stat_Panel/VBoxContainer/GridContainer/Adv_stat_02
@onready var _advanced_stat_03 : PanelContainer = $Stat_Panel/VBoxContainer/GridContainer/Adv_stat_03
@onready var _advanced_stat_04 : PanelContainer = $Stat_Panel/VBoxContainer/GridContainer/Adv_stat_04

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpgradeManager.upgrade_purchased_basic_graph.connect(_activate_basic_graph)
	UpgradeManager.upgrade_purchased_adv_graph.connect(_activate_advanced_stats)

func _activate_basic_graph() ->void:
	_basic_graph_panel.show()

func _activate_advanced_stats() ->void:
	_advanced_stat_01.show()
	_advanced_stat_02.show()
	_advanced_stat_03.show()
	_advanced_stat_04.show()