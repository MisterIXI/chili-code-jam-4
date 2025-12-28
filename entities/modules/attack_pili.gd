extends Node2D

@onready var hit_component :Hitbox_Component = $Hitbox_Component
# animation
func set_damage(damage: float) ->void:
	hit_component.damage_amount = damage