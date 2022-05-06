extends Path2D

signal done_moving

func _ready():
	connect("done_moving", get_node("/root/Main/Restaurant"), "_on_finished_moving")
	

func _on_Walkable_path_follow_finished_path():
	emit_signal("done_moving")
	queue_free()
