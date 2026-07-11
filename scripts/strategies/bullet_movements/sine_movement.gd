class_name SineMovement extends BulletMovementStrategy

@export var frequency : float = 10.0
@export var amplitude: float = 50.0

func move(bullet : Area2D, delta: float,time_alive : float, t_motion = 1) -> void:
	# Forward movement
	var t = motion_curve.sample(t_motion)
	
	var forward = (bullet.transform.x * speed * delta) * t
	# Orthogonal wave movement
	var wave = bullet.transform.y * cos(time_alive * frequency) * amplitude * delta
	
	bullet.global_position += forward + wave
