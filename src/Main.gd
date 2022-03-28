extends Node

onready var interactableObject = null

func _process(_delta):
	if interactableObject != null:
		if Input.is_action_just_pressed("interact"):
			print("interacting with ", interactableObject)
			interactableObject.interact()

func interact():
	pass
#	$HUD.display_dialog(get_node(interactableObject).get_order())
#	$HUD.display_order(get_node(interactableObject).get_order())
#	$HUD.display_order("milk")
#    pause tässä estää sen, että main aktivoi interact() -metodia samalla kun hud tekee dialogia loppuun
#    get_tree().paused = true

#func unpause():
#    get_tree().paused = false
	
#func _on_HUD_dialogue_done():
#    unpause()



#func _on_Customer_area_entered(area):
#	print(area.get_overlapping_areas()[0].name)
#    interactableObject = area.get_overlapping_areas()[0].name

#func _on_NPC_area_exited(_area):
#    interactableObject = null

#func _on_Ghost_NPC_area_exited(area):
#	pass # Replace with function body.


func _on_Ghost_NPC_body_entered(body):
	interactableObject = $Ghost_NPC
	#print(body.get_overlapping_bodies())


func _on_Ghost_NPC_body_exited(body):
	interactableObject = null


func _on_Ghost_NPC2_body_entered(body):
	interactableObject = $Ghost_NPC2


func _on_Ghost_NPC2_body_exited(body):
	interactableObject = null
