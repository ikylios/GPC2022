extends PathFollow2D

signal finished_path

func _process(delta):
		set_offset(get_offset() + 70 * delta)
		if get_unit_offset() == 1:
			emit_signal("finished_path")

	
func set_node_to_remote_transform(node):
	#The NodePath to the remote node, relative to the RemoteTransform2D's position in the scene.
	set_unit_offset(0)
	var node_path = node.get_path()
	$RemoteTransform2D.set_remote_node(node_path)
