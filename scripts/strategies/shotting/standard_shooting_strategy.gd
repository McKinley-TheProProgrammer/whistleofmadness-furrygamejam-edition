extends ShootingStrategy
class_name StandardShootingStrategy


func fire(shooter: Node2D, target: Node2D) -> void:
	
	if not bullet_prefab:
		return
	
	var bullet = bullet_prefab.instantiate()
	
	bullet.global_position = shooter.global_position
	bullet.target = target
	print(shooter.get_parent().name, shooter.is_in_group("player"))
	var is_ally = Bullet.FACTION.PLAYER if ((shooter.is_in_group("player")) or (shooter.is_converted)) else Bullet.FACTION.ENEMY
	bullet.set_faction(is_ally)
	
	shooter.get_tree().current_scene.add_child(bullet)
	
	
