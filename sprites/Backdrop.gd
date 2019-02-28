extends NinePatchRect


	
func _ready():
	print(str(name) + " ready.")
	var node = get_node("../../Interface")
	if node:
		print(node.name)
