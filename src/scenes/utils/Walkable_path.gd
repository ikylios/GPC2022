extends Path2D

func _ready():
	connect("done_moving", get_node("/root/Main/Restaurant"), "_on_finished_moving")
	

func _on_Walkable_path_follow_finished_path():
	emit_signal("done moving")
	queue_free()
