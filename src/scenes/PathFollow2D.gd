extends PathFollow2D

func _process(delta):
	set_offset(get_offset() + 150 * delta)

func _ready():
	# skips to the last frame of offset - otherwise pathfollower will move at ready()
	set_unit_offset(1)
	
func execute_movement():
	if get_unit_offset() == 1:
		set_unit_offset(0)
		
func draw_path():
	draw_polyline(get_parent().get_curve().get_baked_points(), Color.aqua, 5, true)
