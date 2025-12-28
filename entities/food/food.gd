extends Area2D

var food_amound : int = 1

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D) ->void:
	if _body is Bacteria:
		_body.eat(food_amound)
		# tween food get eaten
		# after tween queue free
		queue_free()