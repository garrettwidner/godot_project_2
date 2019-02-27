extends HBoxContainer

var maximum_value = 20
var current_health = 0

var min_value_for_bounce = 5

func initialize(health, maximum):
	maximum_value = maximum
	current_health = health
	$TextureProgress.max_value = maximum
	$Backdrop/HealthDisplay.text = "%s / %s" % [health, maximum]
	

func _on_Interface_health_changed(health):
	animate_value(current_health, health)
	
	#$TextureProgress.value = health
	current_health = health
	
	

func animate_value(start, end):
	if abs(end - start) >= min_value_for_bounce:
		$Tween.interpolate_property($TextureProgress, "value", start, end, 0.4, Tween.TRANS_SINE, Tween.EASE_OUT)
	else:
		$Tween.interpolate_property($TextureProgress, "value", start, end, 0.3, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Tween.interpolate_method(self, "set_count_text", start, end, 0.2, Tween.TRANS_QUART, Tween.EASE_OUT)
	if end < start:
		$AnimationPlayer.play("damage_shake")
	else:
		$AnimationPlayer.play("heal_animation")
	
	
	$Tween.start()
	return
	
func set_count_text(value):
	$Backdrop/HealthDisplay.text = str(round(value)) + "/" + str(maximum_value)
	
	
	pass