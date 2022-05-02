extends Area2D

func _on_Exit_door_area_entered(area):
	if area in get_tree().get_nodes_in_group("customers"):
		$Door_sfx.play()
		area.queue_free()
	else:
		area.show()
		$Door_sfx.play()
