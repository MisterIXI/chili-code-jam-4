extends LineEdit
func _ready() -> void:
	PersistentManager.game_data_loaded.connect(_on_game_loaded_set_name)
func _init() -> void:
	PersistentManager.game_data_loaded.connect(_on_set_bacteria_name)

func _on_set_bacteria_name() ->void:
	text = GameData.p_bacteria_name

func _on_text_changed(_text : String) -> void:
	GameData.p_bacteria_name = _text


func _on_text_submitted(new_text: String) -> void:
	GameData.p_bacteria_name = new_text
func _on_game_loaded_set_name() ->void:
	placeholder_text = GameData.p_bacteria_name