extends "res://scenes/utils/Interactable.gd"

var timer_value = 0
var being_baked = null
var player_last_carried = null

func interact():
	var player = get_parent().get_node("Player")
	var player_item = player.get_carried_item()
	player_last_carried = player_item
	
	if player_item:
		being_baked = get_node("/root/Main/Food_index").try_to_bake(player_item.name)
		
		if being_baked:
			start_baking(player)
		else:
			print("not a bakeable ingredient!")
	elif $pickable:
		player.set_carried_item(being_baked)
		remove_child($pickable)

func start_baking(player):
	$AudioStreamPlayer.play()
	player.drop_carried_item()
	$ProgressBarControl.show()
	$ProgressBarControl/BakeTimer.start()
	set_cooking_in_progress_sprite()
	
func set_cooking_in_progress_sprite():
	var cooking_in_progress_item = Sprite.new()
	cooking_in_progress_item.scale = Vector2(0.7, 0.7)
	cooking_in_progress_item.set_texture(load(player_last_carried.path))
	cooking_in_progress_item.set_name("cooking_in_progress_item")
	cooking_in_progress_item.position = Vector2(cooking_in_progress_item.position.x, cooking_in_progress_item.position.y + 10)
	add_child(cooking_in_progress_item)

func stop_baking():
	var player = get_parent().get_node("Player")
	$ProgressBarControl/BakeTimer.stop()
	$ProgressBarControl.hide()
	$ProgressBarControl/TextureProgress.value=0
	remove_child($cooking_in_progress_item)
	create_pickable_item()
	
func create_pickable_item():
	var pickable_item = Sprite.new()
	pickable_item.set_texture(load(being_baked.path))
	pickable_item.set_name("pickable")
	pickable_item.scale = Vector2(0.7, 0.7)
	pickable_item.position = Vector2(pickable_item.position.x, pickable_item.position.y + 10)
	add_child(pickable_item)

func _on_TextureProgress_value_changed(value):
	if value == 100:
		stop_baking()

