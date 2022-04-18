extends "res://scenes/utils/Interactable.gd"


func interact():
	var player = get_parent().get_node("Player")
	var player_item = player.get_carried_item()
	
	if player_item:
		var chopped_item = get_node("/root/Main/Food_index").try_to_chop(player_item.name)
		
		if chopped_item:
			$AudioStreamPlayer.play()
			player.drop_carried_item()
			yield(get_tree().create_timer(2.0), "timeout")
			player.set_carried_item(chopped_item)
		else:
			print("not a choppable ingredient!")
