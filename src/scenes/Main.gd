extends Node

onready var interactableObject = null

func _process(_delta):
	if interactableObject != null:
		if Input.is_action_just_pressed("interact"):
#			print("interacting with ", interactableObject.name)
			interactableObject.interact()


func _on_Ghost_NPC_customer_area_entered(area):
#	print("area entered ", area.name)
	interactableObject = get_node(area.name)
#	be inspired by the following if overlapping areas are a problem
#	interactableObject = get_node(area.get_overlapping_areas()[0].name)


func _on_Ghost_NPC_customer_area_exited():
	interactableObject = null
