extends HBoxContainer

var maximum_value = 20

func initialize(health, maximum):
	maximum_value = maximum
	$TextureProgress.max_value = maximum
	$Backdrop/HealthDisplay.text = "%s / %s" % [health, maximum_value]

func _on_Interface_health_changed(health):
	$TextureProgress.value = health
	
	$Backdrop/HealthDisplay.text = "%s / %s" % [health, maximum_value]
	pass # replace with function body
