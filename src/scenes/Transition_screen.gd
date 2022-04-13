extends CanvasLayer

#signal transitioned

#func _ready():
#	pass
	#transition()

func fade_to_black():
	$AnimationPlayer.play("fade_to_black")
	
func fade_from_black():
	$AnimationPlayer.play("fade_to_normal")

#func transition():
#	$AnimationPlayer.play("fade_to_black")


#func _on_AnimationPlayer_animation_finished(anim_name):
#	if anim_name == "fade_to_black":
#		emit_signal("transitioned")
#		yield(get_tree().create_timer(0.75), "timeout")
#		$AnimationPlayer.play("fade_to_normal")
#	if anim_name == "fade_to_black":
#		print("finished fading")
