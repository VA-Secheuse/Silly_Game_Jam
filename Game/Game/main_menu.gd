class_name MainMenu extends Control



func _on_start_pressed() -> void:
	get_tree().paused = false
	$".".visible = false


func _on_quit_pressed() -> void:
	get_tree().quit()
