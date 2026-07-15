extends Node
class_name Health

@export var maxHP : int

signal on_damage_taken(amount : int, hpAfter : int)
signal on_hp_recovered(amount : int, hpAfter : int)
signal on_death

var currentHP : int
var isDead : bool

func _ready() -> void:
	currentHP = maxHP

func take_damage(amount : int) -> void:
	currentHP = max(currentHP - amount, 0)
	on_damage_taken.emit(amount, currentHP)
	if currentHP <= 0:
		isDead = true
		on_death.emit()
	 

func recover(amount : int) -> void:
	currentHP = min(currentHP + amount, maxHP)
	on_hp_recovered.emit(amount, currentHP)
