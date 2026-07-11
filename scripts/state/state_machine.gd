class_name StateMachine extends Node

@export var initial_state : State

var current_state : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			child.state_machine = self
			child.enemy = get_parent()
	
	if initial_state:
		transition_to(initial_state.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state:
		current_state.process(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func transition_to(state_name: String) -> void:
	if not has_node(state_name):
		return
	
	if current_state:
		current_state.exit()
	
	current_state = get_node(state_name)
	current_state.enter()
	
	
