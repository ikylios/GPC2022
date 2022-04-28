extends "res://scenes/utils/Interactable.gd"

var timer_value = 0
var being_baked = null

func interact():
	var player = get_parent().get_node("Player")
	var player_item = player.get_carried_item()
	
	if player_item:
		being_baked = get_node("/root/Main/Food_index").try_to_bake(player_item.name)
		
		if being_baked:
			start_baking(player)
		else:
			print("not a bakeable ingredient!")

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
	player.set_carried_item(being_baked)


func _on_TextureProgress_value_changed(value):
	if value == 100:
		stop_baking()

