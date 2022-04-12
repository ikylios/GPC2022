extends PathFollow2D

func _process(delta):
	set_offset(get_offset() + 150 * delta)

func _ready():
	# disables the pathfollower to execute movement at ready()
	# aka skips to the last frame of offset
	set_unit_offset(1)
	
func execute_movement():
	if get_unit_offset() == 1:
		set_unit_offset(0)
