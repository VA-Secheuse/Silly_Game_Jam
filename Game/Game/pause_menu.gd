extends Control

@export var main_menue : MainMenu


func _on_continue_pressed() -> void:
	get_tree().paused = false
	$".".visible = false

func _on_main_menu_pressed() -> void:
	$".".visible = false
	main_menue.visible = true

func _on_restart_pressed() -> void:
	$".".visible = false
	$"../../..".death_screen()
