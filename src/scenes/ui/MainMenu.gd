extends Control


func _on_StartButton_pressed():
	print("Pressed start button")
	get_tree().change_scene("res://scenes/Main.tscn")

func _on_QuitButton_pressed():
	print("Pressed quit button")
	get_tree().quit()
