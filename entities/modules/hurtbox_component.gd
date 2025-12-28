extends Area2D
class_name Hurtbox_Component

@export var health_component :Healt_Component

func damage(_value :float, _entity : Node2D) ->void:
	if health_component:
		health_component.damage(_value, _entity)
	else:
		print("Hurtbox_Component: error health_component null")

