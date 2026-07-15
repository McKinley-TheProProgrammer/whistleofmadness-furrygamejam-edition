class_name EnemyConvertedState extends State

@export var speed : float = 200.0
var fire_rate := 0.0

func enter() -> void:
	enemy.set_collision_layer_value(3,false)
	enemy.set_collision_layer_value(1,true)
	

func physics_update(delta: float) -> void:
	var target = _find_closest_hostile_enemy()
	if not target:
		# Follow player if no enemies exist
		target = get_tree().get_first_node_in_group("player")
		if not target: return
		
	var direction = (target.global_position - enemy.global_position).normalized()
	enemy.velocity = direction * speed
	enemy.move_and_slide()
	
	if enemy.firing_strategy and target.is_in_group("enemy"):
		fire_rate -= delta
		if fire_rate <= 0.0:
			enemy.firing_strategy.fire(enemy, target)
			fire_rate = enemy.firing_strategy.fire_rate

func _find_closest_hostile_enemy() -> Node2D:
	var enemies = get_tree().get_nodes_in_group("enemy")
	var closest = null
	var min_dist = INF
	for e in enemies:
		if e != enemy and not e.is_converted:
			var dist = enemy.global_position.distance_to(e.global_position)
			if dist < min_dist:
				min_dist = dist
				closest = e
	return closest
