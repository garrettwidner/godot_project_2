extends Control

signal health_changed(health)
signal button_pressed(icon_name)

var health_node

var icon = {"bless" : "WaterIcon", "swipe" : "SwordIcon", "hand" : "HandIcon"}

func _ready():
	for node in get_tree().get_nodes_in_group(game.GROUP_PLAYER):
		if node.name == "Player":
			health_node = node.get_node("Health")
			break
	$WaterBar.initialize(health_node.health, health_node.max_health)

func _on_Health_health_changed(health):
	emit_signal("health_changed", health)
	pass # replace with function body

func _input(event):
	if event.is_action("bless") and !event.is_echo() and event.is_pressed():
		emit_signal("button_pressed", icon["bless"])
	elif event.is_action("swipe") and !event.is_echo() and event.is_pressed():
		emit_signal("button_pressed", icon["swipe"])
	elif event.is_action("hand") and !event.is_echo() and event.is_pressed():
		emit_signal("button_pressed", icon["hand"])