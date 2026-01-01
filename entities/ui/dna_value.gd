extends RichTextLabel


func _ready() -> void:
	text = str(int(GameData.p_dna_currency))

func _physics_process(_delta: float) -> void:
	##TODO LATER FORMAT TEXT
	text = str(int(GameData.p_dna_currency))

