class_name BulletMovementStrategy extends Resource

@export var speed : float = 400.0
@export var motion_curve : Curve = Curve.new()

signal on_time_alive_ended

func move(bullet : Area2D, delta: float, time_alive: float,t_motion = 1) -> void:
	pass
	
