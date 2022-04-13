extends Area2D

func _on_Exit_door_area_entered(area):
	$Door_sfx.play()
	area.queue_free()
