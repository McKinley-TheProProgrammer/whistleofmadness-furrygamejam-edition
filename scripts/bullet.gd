class_name Bullet extends Area2D

enum FACTION {PLAYER, ENEMY}

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
			

func set_faction(faction : FACTION) -> void:
	for i in range(1,5):
		set_collision_layer_value(i,false)
		set_collision_mask_value(i,false)
	
	if faction == FACTION.PLAYER:
		# Bullet from the Allies (Player or Converted Enemy)
		set_collision_layer_value(2,true) # Layer 2: PlayerBullets
		set_collision_mask_value(3, true) # Mask 3: Hit Enemies
	else:
		# Enemy Bullet
		set_collision_layer_value(4, true)
		set_collision_mask_value(1, true)
		
		

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage, is_conversion_bullet)
		queue_free()
	
