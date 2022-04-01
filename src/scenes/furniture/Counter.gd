extends "res://scenes/Interactable.gd"

var item = null
var item_sprite = null


#func _ready():
#	var player = get_parent().get_node("Player")
	#connect("get_ingredient", player, "_on_Counter_interacted")
	#connect("drop_carried_item", player, "_on_Counter_interacted")


func interact():
	var player = get_parent().get_node("Player")
	var player_item = player.get_carried_item()
	
	if player_item and !item:
		print("player item ", player_item)
		item = player_item
		player.drop_carried_item()
		set_item_sprite()
	else:
		print("could not set item on counter")
		

func set_item_sprite():
	print("set on counter: ", item)
	item_sprite = Sprite.new()
	add_child(item_sprite)
	item_sprite.set_texture(load(item.path))
	item_sprite.position = Vector2($Sprite.position.x, $Sprite.position.y - 7)
	
