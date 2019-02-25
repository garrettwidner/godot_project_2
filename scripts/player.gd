extends KinematicBody2D

const GRAVITY = 12
const JUMP_VELOCITY = 250
const UP = Vector2(0,-1)
const SPEED = 100
const MAX_FALL_SPEED = 300

const blessing_water = preload("res://scenes/Blessing_Water.tscn")
var blessing_start_range = Vector2(7,10)
var blessing_drops = 17

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite

var is_facing_right = true
var velocity = Vector2()
var is_grounded = true
var is_attacking = false

var jump_count = 0
var max_jumps = 2

onready var machete_area = get_node("Machete/Machete_Area")
onready var machete_sprite = get_node("Machete/Sprite")

func _ready():
	add_to_group(game.GROUP_PLAYER)
	
	$AnimationPlayer.connect("animation_finished", self, "animation_ended")
	
	machete_sprite.hide()

func _physics_process(delta):

	
	velocity.y += GRAVITY
	velocity = set_horizontal_speed(velocity)
	velocity = jump(velocity)
	
	change_position2d()
	
	handle_blessing()
	handle_swipe()
	

	check_flip(velocity)

	# function returns what is left over after collisions happen
	velocity = move_and_slide(velocity, UP)
	
	
	if !is_attacking:
		if is_grounded:
			if velocity.x == 0:
				play_anim("idle")
			else:	
				play_anim("walk")
		else:
			if velocity.y > 0:
				play_anim("fall")
			else:
				play_anim("jump")
	
	is_grounded = is_on_floor()
	if is_grounded:
		jump_count = 0	
	
	pass

func set_horizontal_speed(velocity):	
	if(is_attacking and is_grounded):
		velocity.x = 0
		return velocity
	
	if Input.is_action_pressed("move_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
	else:
		velocity.x = 0
	return velocity

func change_position2d():
	if Input.is_action_pressed("move_right"):
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("move_left"):
		if sign($Position2D.position.x) == 1: 
			$Position2D.position.x *= -1

func jump(velocity):
#	if Input.is_action_just_pressed("jump"):
#		if is_on_floor():
#			velocity.y = -JUMP_VELOCITY
	if Input.is_action_just_pressed("jump"):
		if !is_grounded && jump_count == 0:
			jump_count = 2
			velocity.y = -JUMP_VELOCITY
		
		elif jump_count < max_jumps:
			jump_count += 1
			velocity.y = -JUMP_VELOCITY
	
	return velocity

func handle_blessing():
	if Input.is_action_just_pressed("bless") and !is_attacking:
		
		is_attacking = true
		
		if is_grounded:
			play_anim("bless")
		else:
			play_anim("air_bless")
			
		
		
		for i in range(blessing_drops):
			
			var blessing = blessing_water.instance()
			
			if sign($Position2D.position.x) == 1:
				blessing.fling(1)
			else:
				blessing.fling(-1)
			get_parent().add_child(blessing)
			
			#modify start position for each droplet
			randomize()
			var yMod = rand_range(-blessing_start_range.y, blessing_start_range.y)
			var xMod = rand_range(-blessing_start_range.x, blessing_start_range.x)
			
			blessing.position = $Position2D.global_position + Vector2(xMod, yMod)
			
		
func handle_swipe():
	if Input.is_action_just_pressed("swipe") and !is_attacking:
		is_attacking = true
		machete_area.monitoring = true
		
		if is_grounded:
			play_anim("ground_swipe")
		else:
			play_anim("air_swipe")

func check_flip(velocity):
	if is_facing_right and velocity.x < 0:
		flip()
	elif !is_facing_right and velocity.x > 0:
		flip()
	pass
	
func flip():
	is_facing_right = !is_facing_right
	sprite.flip_h = !sprite.flip_h
	machete_sprite.flip_h = !machete_sprite.flip_h
	machete_area.scale *= -1
	
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)

	
func animation_ended(anim_name):
	if ("bless" in anim_name or "swipe" in anim_name) and is_attacking:
		is_attacking = false
		machete_area.monitoring = false
		

func _on_Machete_Area_body_entered(body):
	if body.has_method("get_hit"):
		body.get_hit(1)
	
	pass # replace with function body
