class_name EnemyPatrollingState extends State

@export var speed: float = 150.0

func physics_update(delta: float) -> void:
	var target = enemy.get_target();
