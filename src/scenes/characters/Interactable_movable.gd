extends KinematicBody2D

var interactable: bool = false


func _process(delta):
	if Input.is_action_just_pressed("interact") and interactable:
		interact()

func interact():
	pass

func _on_Interaction_area_body_entered(body):
	interactable = true

func _on_Interaction_area_body_exited(body):
	interactable = false