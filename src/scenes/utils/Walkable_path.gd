extends Path2D

signal done_entering

func _ready():
	connect("done_entering", get_node("/root/Main/Restaurant"), "_on_finished_entering")
	

func _on_Walkable_path_follow_finished_path():
	emit_signal("done_entering")
	queue_free()
