class_name Enemy extends CharacterBody2D

@export var health: int = 3
@export var is_convertible: bool = true
@export var firing_strategy: ShootingStrategy

var is_converted: bool = false
@onready var state_machine: StateMachine = $StateMachine

func _ready() -> void:
	add_to_group("enemy")

func get_target() -> Node2D:
	# Returns player if hostile, returns other enemies if converted
	if is_converted:
		return null # Handled by ConvertedState logic
	return get_tree().get_first_node_in_group("player")

func take_damage(amount: int, is_conversion: bool) -> void:
	if is_converted: return # Invincible or handles damage differently as ally
	
	health -= amount
	if health <= 0:
		if is_convertible and is_conversion:
			convert_to_ally()
		else:
			die()

func convert_to_ally() -> void:
	is_converted = true
	health = 5 # Refill health as an ally
	state_machine.transition_to("Converted")

func die() -> void:
	queue_free()
