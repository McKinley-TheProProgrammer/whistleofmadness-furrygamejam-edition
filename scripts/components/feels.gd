extends Node
class_name Feels

@export var target_sprite : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_saturation(2.0)
	set_blink_intensity(0.0)
	set_blink_frequency(0.0)

func damage_taken():
	set_blink_color(Color.RED)
	set_blink_frequency(15.0)
	set_blink_intensity(0.8)
	
	var tilt_tween = get_tree().create_tween()
	tilt_tween.tween_property(get_parent(), "rotation", 5, .15)
	tilt_tween.chain().tween_property(get_parent(),"rotation", 0, .1)
	
	await get_tree().create_timer(0.5).timeout
	
	set_blink_intensity(0.0)
	set_blink_frequency(0.0)


func set_saturation(amount : int) -> void:
	target_sprite.material.set_shader_parameter("saturation_amount",amount)

func set_blink_intensity(intensity: float):
	target_sprite.material.set_shader_parameter("blink_max_intensity", intensity)

func set_blink_color(color: Color):
	target_sprite.material.set_shader_parameter("blink_color", color)

func set_blink_frequency(freq: float):
	target_sprite.material.set_shader_parameter("blink_frequency", freq)
