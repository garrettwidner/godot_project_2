extends NinePatchRect


	
func _ready():
	var node = get_parent().get_parent()
	if node and node.name == "Interface":
		node.connect("button_pressed", self, "_button_press")

func _button_press(icon_name):
	
	if icon_name == name:
		$AnimationPlayer.play("press")