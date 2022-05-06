extends "res://scenes/utils/Interactable.gd"

var timer_value = 0
var being_fried = null

func interact():
	var player = get_parent().get_node("Player")
	var player_item = player.get_carried_item()

	if player_item:
		being_fried = get_node("/root/Main/Food_index").try_to_fry(player_item.name)

		if being_fried:
			start_frying(player)
		else:
			print("not a fryable ingredient!")
	elif $pickable:
		player.set_carried_item(being_fried)
		remove_child($pickable)

func start_frying(player):
	$AudioStreamPlayer.play()
	player.drop_carried_item()
	$ProgressBarControl.show()
	$ProgressBarControl/FryTimer.start()
	$FryingPanSprite/Particles2D.emitting = true

func stop_frying():
	var player = get_parent().get_node("Player")
	$ProgressBarControl/FryTimer.stop()
	$ProgressBarControl.hide()
	$ProgressBarControl/TextureProgress.value=0
	$FryingPanSprite/Particles2D.emitting = false
	create_pickable_item()

func create_pickable_item():
	var pickable_item = Sprite.new()
	pickable_item.set_texture(load(being_fried.path))
	pickable_item.set_name("pickable")
	pickable_item.position = Vector2(pickable_item.position.x, pickable_item.position.y)
	add_child(pickable_item)

func _on_TextureProgress_value_changed(value):
	if value == 100:
		stop_frying()
