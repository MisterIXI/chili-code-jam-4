extends VBoxContainer

@onready var graph_button : MarginContainer = $Button_06
@onready var adv_graph_button : MarginContainer =$Button_07
@onready var auto_upgrader :MarginContainer  =$Button_08
func _ready() -> void:
	UpgradeManager.upgrade_purchased_basic_graph.connect(_on_basic_graph_purchased)
	UpgradeManager.upgrade_purchased_adv_graph.connect(_on_adv_graph_purchased)
	UpgradeManager.upgrade_purchased_auto_upgrader.connect(_on_auto_upgrader_purchased)

func _on_auto_upgrader_purchased() ->void:
	if auto_upgrader:
		auto_upgrader.queue_free()

func _on_adv_graph_purchased() ->void:
	if adv_graph_button:
		adv_graph_button.queue_free()
	if auto_upgrader:
		auto_upgrader.show()

func _on_basic_graph_purchased() ->void:
	if graph_button:
		graph_button.queue_free()
	if adv_graph_button:
		adv_graph_button.show()
