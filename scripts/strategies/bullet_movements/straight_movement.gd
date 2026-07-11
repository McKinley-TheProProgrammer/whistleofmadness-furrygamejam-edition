class_name StraightMovement extends BulletMovementStrategy

func move(bullet : Area2D, delta: float,time_alive : float, t_motion = 1) -> void:
	var motion_move = (bullet.transform.x * speed * delta) * motion_curve.sample(t_motion);
	bullet.global_position += motion_move
