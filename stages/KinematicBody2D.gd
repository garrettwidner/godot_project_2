extends KinematicBody2D

var GRAVITY = 12
const JUMP_VELOCITY = 200
const UP = Vector2(0,-1)
const SPEED = 100

var motion = Vector2()

func _physics_process(delta):
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	elif Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		motion.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_VELOCITY
	
	# function returns what is left over after collisions happen
	motion = move_and_slide(motion, UP)
	
	pass