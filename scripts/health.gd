extends Node

signal health_changed(health)
signal health_depleted

var health = 0
export(int) var max_health = 23

func _ready():
	health = max_health
	emit_signal("health_changed", health)
	
func _input(event):
	if event is InputEventKey and event.scancode == KEY_U and not event.is_echo() and event.is_pressed():
		take_damage(1)
	elif event is InputEventKey and event.scancode == KEY_I and not event.is_echo() and event.is_pressed():
		heal(1)
	
func take_damage(amount):
	health -= amount
	health = max(0, health)
	emit_signal("health_changed", health)
	
func heal(amount):
	health += amount
	health = min(health, max_health)
	emit_signal("health_changed", health)