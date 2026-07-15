extends Node

@export var enemy_scenes: Array[PackedScene] # Add your 3 enemy variants here
@export var spawn_points : Array[Marker2D]

@export var off_screen_margin : float = 50

@onready var game_timeline: AnimationPlayer = $GameTimeline

var current_timeline : StringName

func spawn_enemies_from_spawnpoints(enemy_scene : PackedScene,enemy_count: int, interval_between_spawns : float = .5) -> void:
	for i in range(enemy_count):
		var spawn_point = spawn_points[i % (len(spawn_points) + 1)]
		
		await get_tree().create_timer(interval_between_spawns).timeout
		
		var enemy_spawned = enemy_scene.instantiate()
		
		var enemy_move_tween = get_tree().create_tween()
		enemy_move_tween.tween_property(enemy_spawned,"position", spawn_point,2.0)
		
		add_child(enemy_spawned)

func spawn_enemy_randomly() -> void:
	if enemy_scenes.is_empty(): 
		return
		
	var random_enemy = enemy_scenes.pick_random()
	spawn_enemy(random_enemy)

func spawn_enemy(enemy_scene : PackedScene) -> void:
	
	var random_enemy = enemy_scene.instantiate()
	var spawn_pos := Vector2.ZERO
	
	var viewport_rect = get_viewport().get_visible_rect()
	var canvas_transform = get_viewport().canvas_transform
	
	# Calcula as coordenadas globais exatas do que a câmera está vendo agora
	var screen_top_left = -canvas_transform.origin / canvas_transform.get_scale()
	var screen_size = viewport_rect.size / canvas_transform.get_scale()
	
	var left = screen_top_left.x
	var right = screen_top_left.x + screen_size.x
	var top = screen_top_left.y
	var bottom = screen_top_left.y + screen_size.y
	
	# Sorteia se vai nascer na Horizontal (Cima/Baixo) ou Vertical (Esquerda/Direita)
	if randf() > 0.5:
		# Nasce no Eixo X aleatório e nos extremos do Eixo Y
		spawn_pos.x = randf_range(left, right)
		spawn_pos.y = (top - off_screen_margin) if randf() > 0.5 else (bottom + off_screen_margin)
	else:
		# Nasce nos extremos do Eixo X e no Eixo Y aleatório
		spawn_pos.x = (left - off_screen_margin) if randf() > 0.5 else (right + off_screen_margin)
		spawn_pos.y = randf_range(top, bottom)
		
	random_enemy.global_position = spawn_pos
	add_child(random_enemy)
