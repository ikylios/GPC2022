extends Node

var days_remaining = 2

func _ready():
	begin_day()


func begin_day():
	print("Day begins")
	yield(get_tree().create_timer(1.0), "timeout")
	$Transition_screen.fade_from_black()
	$Restaurant.start_day()


func _on_Restaurant_end_day():
	yield(get_tree().create_timer(1.5), "timeout")
	days_remaining -= 1
	$Transition_screen.fade_to_black()
	if days_remaining != 0:
		print("Day ends. Days remaining: " + str(days_remaining))
		begin_day()
	else:
		print("All days have been played. Goodbye.")
