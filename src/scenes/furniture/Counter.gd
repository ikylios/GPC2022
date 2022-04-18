extends "res://scenes/utils/Interactable.gd"

var item = null
var item_sprite = null

func interact():
	var player = get_parent().get_node("Player")
	var player_item = player.get_carried_item()
	
	if player_item and !item:
		$AudioStreamPlayer.play()
		item = player_item
		player.drop_carried_item()
		set_item_sprite()
	
	elif !player_item and item:
		$AudioStreamPlayer.play()
		player.set_carried_item(item)
		item = null
		remove_child(item_sprite)
		
	elif player_item and item:
		var meal = null
		meal = try_to_cook([item.name, player_item.name])
		if meal:
			$AudioStreamPlayer.play()
			player.drop_carried_item()
			item = meal
			item_sprite.set_texture(load(item.path))


func set_item_sprite():
	item_sprite = Sprite.new()
	add_child(item_sprite)
	item_sprite.set_texture(load(item.path))
	item_sprite.position = Vector2($Sprite.position.x, $Sprite.position.y - 10)
	

func try_to_cook(ingredients):
	var result = get_node("/root/Main/Food_index").try_to_cook(ingredients)
	
	if !result:
		print("didn't find a meal with those ingredients")
	
	return result
