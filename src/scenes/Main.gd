extends Node

var days_remaining = 2

func _ready():
	get_tree().change_scene("res://scenes/ui/MainMenu.tscn")


func begin_day():
	$Transition_screen.transition()
	$Restaurant.start_day()

func _on_Restaurant_end_day():
	days_remaining -= 1
	if days_remaining != 0:
		begin_day()
	else:
		print("all days have been played. goodbye.")
