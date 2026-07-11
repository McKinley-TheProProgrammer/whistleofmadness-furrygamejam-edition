class_name EnemyConvertedState extends State

@export var fire_rate : float = 1.0
var fire_timer : float = 0.0

var target : Player

func enter() -> void:
	target = Global.player

func physics_update(delta: float) -> void:
	
	if not is_instance_valid(target):
		state_machine.transition_to("")
