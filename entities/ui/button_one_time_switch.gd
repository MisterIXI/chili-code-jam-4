extends VBoxContainer

@onready var graph_button : MarginContainer = $Button_06
@onready var adv_graph_button : MarginContainer =$Button_07
@onready var auto_upgrader :MarginContainer  =$Button_08

func switch_one_time_buttons(upgrade_string :String)->void:

	match upgrade_string:
		"Unlock Graph":
			graph_button.queue_free()
			adv_graph_button.show()
		"Advanced Graph":
			adv_graph_button.queue_free()
			auto_upgrader.show()
		"Auto Upgrader":
			auto_upgrader.queue_free()
			
		_:
			print("One time button switch error : ", upgrade_string)