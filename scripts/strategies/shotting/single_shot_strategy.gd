class_name SingleShotStrategy extends ShootingStrategy


func fire(shooter: Node2D, target: Node2D) -> void:
	if not bullet_prefab:
		return
		
	var bullet = bullet_prefab.instantiate()
	bullet.global_position = shooter.global_position
	bullet.target = target # Useful if using HomingMovement
	
	if is_instance_valid(target):
		bullet.look_at(target.global_position)
	
	shooter.get_tree().current_scene.add_child(bullet)
	
