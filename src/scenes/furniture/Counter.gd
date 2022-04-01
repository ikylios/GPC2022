extends "res://scenes/Interactable.gd"

var item = null
var item_sprite = null


func interact():
	var player = get_parent().get_node("Player")
	var player_item = player.get_carried_item()
	
	if player_item and !item:
		item = player_item
		player.drop_carried_item()
		set_item_sprite()
	
	elif !player_item and item:
		player.set_carried_item(item)
		item = null
		remove_child(item_sprite)


func set_item_sprite():
	item_sprite = Sprite.new()
	add_child(item_sprite)
	item_sprite.set_texture(load(item.path))
	item_sprite.position = Vector2($Sprite.position.x, $Sprite.position.y - 7)
	

