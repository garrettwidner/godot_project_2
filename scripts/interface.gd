extends Control

signal health_changed(health)

var health_node

func _ready():
	for node in get_tree().get_nodes_in_group(game.GROUP_PLAYER):
		if node.name == "Player":
			health_node = node.get_node("Health")
			break
	$WaterBar.initialize(health_node.health, health_node.max_health)

func _on_Health_health_changed(health):
	emit_signal("health_changed", health)
	pass # replace with function body
