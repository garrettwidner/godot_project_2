extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30
const UP = Vector2(0,-1)

var hp = 3

var velocity = Vector2()

var direction = 1

var is_flashing = false
var flash_time = 0.2
onready var timer = get_node("Timer")
onready var sprite = get_node("Sprite")
var flash_color = Color(0, .3, .3)

var is_dead = false

func _ready():
	add_to_group(game.GROUP_ENEMIES)
	pass
	
func get_hit(damage):
	if !is_dead:
		hp -= damage
		if hp <= 0:
			hp = 0
			die()
		else:
			flash()
		
func flash():
	is_flashing = true
	timer.wait_time = flash_time
	timer.start()
	print("start flash")
	sprite.modulate = flash_color
	pass
	
func end_flash():
	is_flashing = false
	timer.stop()
	print("end_flash")
	sprite.modulate = Color(1,1,1)
	
func die():
	end_flash()
	is_dead = true
	velocity = Vector2(0,0)
	$AnimationPlayer.play("die")

func _physics_process(delta):
	if is_dead == false:
		velocity.x = SPEED * direction
		
		$AnimationPlayer.play("idle")
		if direction == 1:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true
		
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, UP)
	
	
	if is_on_wall():
		direction *= -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction *= -1
		$RayCast2D.position.x *= -1
	
	pass

func _on_Timer_timeout():
	end_flash()
	pass # replace with function body
