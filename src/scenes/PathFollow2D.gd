extends PathFollow2D

var init = true

func _process(delta):
		set_offset(get_offset() + 150 * delta)

func _ready():
	# skips to the last frame of offset - otherwise pathfollower will move at ready()
	set_unit_offset(1)
	#set_offset(0)
	
func execute_movement():
	if get_unit_offset() == 1:
		set_unit_offset(0)
		
func draw_path():
	draw_polyline(get_parent().get_curve().get_baked_points(), Color.aqua, 5, true)
	
func set_node_to_remote_transform(node_path):
	#The NodePath to the remote node, relative to the RemoteTransform2D's position in the scene.
	$RemoteTransform2D.set_remote_node()
