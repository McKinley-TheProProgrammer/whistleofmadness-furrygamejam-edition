class_name Player extends CharacterBody2D

@export var move_speed = 300.0
@export var turret_holder : Node
@export var bullet : PackedScene

func _physics_process(delta: float) -> void:
	# Add the gravity.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_right","move_left","move_up","move_down")
	
	if direction.x:
		velocity.x = direction.x * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	if direction.y:
		velocity.y = direction.y * move_speed
	else :
		velocity.y = move_toward(velocity.y,0,move_speed);
	
	move_and_slide()


func convert_to_turret(enemy) -> void:
	# CONVERTS ENEMIES TO ALLIES FOR THE PLAYER
	turret_holder.add_child(enemy)
