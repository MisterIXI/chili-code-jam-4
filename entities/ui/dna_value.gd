extends RichTextLabel


func _ready() -> void:
	GameData.dna_changed.connect(_on_dna_changed)
	text = str(GameData.player_progress["dna_currency"])

func _on_dna_changed(_value :float) ->void:
	##TODO LATER FORMAT TEXT
	text = str(_value)