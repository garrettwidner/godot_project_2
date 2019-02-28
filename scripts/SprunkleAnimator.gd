extends KinematicBody2D

var has_grown = false

func _ready():
	get_node("../../AnimationPlayer").play("Reset")
	pass

func grow():
	if !has_grown:
		#print("It should grow")
		get_node("../../AnimationPlayer").play("Grow")
		has_grown = true