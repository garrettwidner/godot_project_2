extends RigidBody2D

var start_velocity = Vector2(170,-100)
var trajectory_randomizer_range = Vector2(10,30)
var alpha_range_min = .15;
var alpha_range_max = .6;
var growable_layer = 4

func _ready():
	contact_monitor = true
	contacts_reported = 1
	
	
	$Sprite.modulate.a = rand_range(alpha_range_min, alpha_range_max)
	
	connect("body_entered", self, "play_splash_animation")
	connect("body_entered", self, "trigger_growable")
	$BlessingAnimation.connect("animation_finished", self, "destroy_self")
	
	pass
	
func fling(dir):
	randomize()
	var random_traj_x = rand_range(-trajectory_randomizer_range.x, trajectory_randomizer_range.x)
	var random_traj_y = rand_range(-trajectory_randomizer_range.y, trajectory_randomizer_range.y)
	
	apply_impulse(Vector2(), Vector2((start_velocity.x + random_traj_x) * dir, start_velocity.y + random_traj_y))
		

func _physics_process(delta):
	pass
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	 
	
func play_splash_animation(other):
	var random_splash = randi() % 4 + 1
	$BlessingAnimation.play("splash" + str(random_splash))
	
func trigger_growable(other):
	if other.has_method("grow"):
		other.grow()
	pass

func destroy_self(anim_name):
	queue_free()
