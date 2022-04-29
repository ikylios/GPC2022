extends "res://scenes/utils/Interactable.gd"

var timer_value = 0
var being_baked = null
var pickable_item = false

func interact():
	var player = get_parent().get_node("Player")
	var player_item = player.get_carried_item()
	
	if player_item:
		being_baked = get_node("/root/Main/Food_index").try_to_bake(player_item.name)
		
		if being_baked:
			start_baking(player)
		else:
			print("not a bakeable ingredient!")
	elif pickable_item:
		player.set_carried_item(being_baked)
		pickable_item = false
		remove_child($pickable)

func start_baking(player):
	$AudioStreamPlayer.play()
	player.drop_carried_item()
	$ProgressBarControl.show()
	$ProgressBarControl/BakeTimer.start()

func stop_baking():
	var player = get_parent().get_node("Player")
	$ProgressBarControl/BakeTimer.stop()
	$ProgressBarControl.hide()
	$ProgressBarControl/TextureProgress.value=0
	create_pickable_item()
	
func create_pickable_item():
	pickable_item = true
	var pickable_item_node = Sprite.new()
	pickable_item_node.set_texture(load(being_baked.path))
	pickable_item_node.set_name("pickable")
	pickable_item_node.position = Vector2(pickable_item_node.position.x, pickable_item_node.position.y + 10)
	add_child(pickable_item_node)


func _on_TextureProgress_value_changed(value):
	if value == 100:
		stop_baking()

