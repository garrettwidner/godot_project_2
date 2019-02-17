extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30
const UP = Vector2(0,-1)

var velocity = Vector2()

var direction = 1

var is_dead = false

func _ready():
	add_to_group(game.GROUP_ENEMIES)
	pass
	
func die():
	is_dead = true
	velocity = vector2(0,0)
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