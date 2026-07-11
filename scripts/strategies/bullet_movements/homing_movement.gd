class_name HomingMovement extends BulletMovementStrategy

@export var turn_speed: float = 3.0

func move(bullet : Area2D, delta: float, time_alive : float, t_motion = 1) -> void:
	var t = motion_curve.sample(t_motion)
	if is_instance_valid(bullet.target):
		var direction = (bullet.target.global_position - bullet.global_position).normalized()
		var desired_rotation = direction.angle()
		# Smoothly interpolate rotation towards the target
		bullet.rotation = lerp_angle(bullet.rotation, desired_rotation, (turn_speed * delta) * t)
	
	bullet.global_position += (bullet.transform.x * speed * delta) * t
