class_name Bullet extends Area2D

@export var movement_strategy : BulletMovementStrategy
@export var damage : int = 1
@export var is_conversion_bullet : bool = false

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var target : Node2D = null

var t_motion := 0.0;
var time_alive := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	t_motion += delta
	t_motion = clampf(t_motion,0.0,1.0)
	time_alive += delta
	if movement_strategy:
		movement_strategy.move(self,delta,time_alive,t_motion);
			
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
