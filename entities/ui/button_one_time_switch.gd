extends VBoxContainer

@onready var graph_button : MarginContainer = $Button_06
@onready var adv_graph_button : MarginContainer =$Button_07
@onready var auto_upgrader :MarginContainer  =$Button_08
func _ready() -> void:
	UpgradeManager.upgrade_purchased_basic_graph.connect(_on_basic_graph_purchased)
	UpgradeManager.upgrade_purchased_adv_graph.connect(_on_adv_graph_purchased)
	UpgradeManager.upgrade_purchased_auto_upgrader.connect(_on_adv_graph_purchased)

func _on_auto_upgrader_purchased() ->void:
	auto_upgrader.queue_free()
func _on_adv_graph_purchased() ->void:
	adv_graph_button.queue_free()
	auto_upgrader.show()

func _on_basic_graph_purchased() ->void:
	graph_button.queue_free()
	adv_graph_button.show()
