extends Node
class_name Healt_Component

signal health_changed(_value :float)
signal died()

@export var max_health :float = 10
@export var current_health : float = 10

func set_health(_value : float) ->void:
    current_health = _value
    if current_health > max_health:
        current_health = max_health
    
    health_changed.emit(current_health)

func damage(_value :float,_entity : Node2D) ->void:
    if !_check_death(_value):
        current_health -= _value
        health_changed.emit(current_health)
        print("Healt_Component: Damage by _entity and _amount :" % [_value, _entity])

func absorb(_value : float) ->void:
    current_health += _value
    if current_health > max_health:
        current_health = max_health
    
    health_changed.emit(current_health)

func _check_death(_value : float) ->bool:
    if (current_health - _value) < 0:
         current_health = 0
         died.emit()
         return true
    else: 
        return false