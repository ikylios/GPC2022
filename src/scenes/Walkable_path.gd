extends Path2D

func _on_Walkable_path_follow_finished_path():
	queue_free()
