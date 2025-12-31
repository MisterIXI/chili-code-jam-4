extends RichTextLabel


func _ready() -> void:
	text = str(GameData.player_progress["dna_currency"])

func _physics_process(_delta: float) -> void:
	##TODO LATER FORMAT TEXT
	text = str(GameData.player_progress["dna_currency"])

