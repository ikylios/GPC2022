extends Popup

func _on_ContinueButton_pressed():
	print("Pressed continue")
	get_tree().paused = false
	self.hide()


func _on_QuitButton_pressed():
	get_tree().quit()
