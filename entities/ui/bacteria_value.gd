extends RichTextLabel


# Called when the

func _ready() -> void:
	text = GameData.num_to_scientific(GameData.p_bacterias)

func _physics_process(_delta: float) -> void:
	##TODO LATER FORMAT TEXT
	text = GameData.num_to_scientific(GameData.p_bacterias)