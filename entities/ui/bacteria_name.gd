extends TextEdit

func _init() -> void:
	PersistentManager.game_data_loaded.connect(_on_set_bacteria_name)

func _on_set_bacteria_name() ->void:
	text = GameData.p_bacteria_name

func _on_text_changed() -> void:
	GameData.p_bacteria_name = text


func _on_text_submitted(new_text: String) -> void:
	GameData.p_bacteria_name = new_text
