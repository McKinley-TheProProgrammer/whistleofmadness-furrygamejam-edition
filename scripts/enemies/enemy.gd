class_name Enemy extends CharacterBody2D

@export var health: Health
@export var hits_to_convert : int = 1

@export var is_convertible: bool = true
@export var on_converted_sprite : Texture2D
@export var firing_strategy: ShootingStrategy

@export var feels_component : Feels

@onready var state_machine: StateMachine = $StateMachine
@onready var sprite_2d: Sprite2D = $Sprite2D


var is_converted: bool = false

func _ready() -> void:
	add_to_group("enemy")

func get_target() -> Node2D:
	# Returns player if hostile, returns other enemies if converted
	if is_converted:
		return null # Handled by ConvertedState logic
	return get_tree().get_first_node_in_group("player")

func take_damage(amount: int, is_conversion: bool) -> void:
	
	if is_convertible and is_conversion:
		convert_to_ally()
	else:
		health.take_damage(amount)
		
	

func convert_to_ally() -> void:
	is_converted = true
	health.recover(5) # Refill health as an ally
	sprite_2d.texture = on_converted_sprite
	state_machine.transition_to("EnemyConvertedState")

func die() -> void:
	queue_free()


func _on_damage_taken(amount: int, hpAfter: int) -> void:
	feels_component.damage_taken()


func _on_health_dead() -> void:
	var dead_tween = get_tree().create_tween()
	dead_tween.tween_property(self,"global_position",Vector2.DOWN * 100,3).as_relative().set_ease(Tween.EASE_OUT)
	dead_tween.tween_property(self,"global_position", Vector2.RIGHT, .1).set_trans(Tween.TRANS_SINE)
	await dead_tween.finished
	die()
