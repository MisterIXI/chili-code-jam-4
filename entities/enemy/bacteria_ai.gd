extends Node2D

@export var speed : float = 500.0
@export var damage : float = 1
@export var health : float = 10

@onready var health_component : Healt_Component =$Healt_Component
@onready var attack_pili_mother : Node2D =$attack_pili_mother
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component.set_health(health)
	for x in attack_pili_mother.get_children():
		x.set_damage(damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
