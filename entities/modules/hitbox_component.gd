extends Area2D
class_name Hitbox_Component

var damage_amount : float = 0

func _ready() -> void:
    area_entered.connect(_on_area_entered)


func _on_area_entered (_area : Area2D) ->void: 
    if _area is Hurtbox_Component:
        #Effect
        _area.damage(damage_amount, _area.get_parent().get_parent().get_parent())
        print("get parent :", _area.get_parent().get_parent().get_parent())
    
