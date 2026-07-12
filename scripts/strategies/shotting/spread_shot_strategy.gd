class_name SpreadShotStrategy extends ShootingStrategy

@export var bullet_count : int = 3
@export var spread_angle_degrees: float = 45.0

func fire(shooter: Node2D, target: Node2D) -> void:
	if not bullet_prefab:
		return
	
	var base_rotation = 0.0
	if is_instance_valid(target):
		base_rotation = (target.global_position - shooter.global_position).angle()
	
	var angle_step = deg_to_rad(spread_angle_degrees) / (bullet_count - 1)
	var start_angle = base_rotation - deg_to_rad(spread_angle_degrees) / 2.0
	
	var is_ally = Bullet.FACTION.PLAYER if ((shooter.is_in_group("player")) or (shooter.is_converted)) else Bullet.FACTION.ENEMY
	
	for i in range(bullet_count):
		var bullet = bullet_prefab.instantiate()
		bullet.global_position = shooter.global_position
		bullet.rotation = start_angle + (i * angle_step)
		#Apply faction
		bullet.set_faction(is_ally)
		
		shooter.get_tree().current_scene.add_child(bullet)
