extends Node

var customers_for_the_day
var customers_to_serve
var days_remaining = 2

func _ready():
	get_tree().change_scene("res://scenes/ui/MainMenu.tscn")
	start_day()


func start_day():
	$Transition_screen.transition()
	$Restaurant.start_day()

func _on_Restaurant_end_day():
	print("all customers for the day have been served. good night.")
	print("zzzzz.....................")
	days_remaining -= 1
	if days_remaining != 0:
		start_day()
	else:
		print("all days have been played. goodbye.")
