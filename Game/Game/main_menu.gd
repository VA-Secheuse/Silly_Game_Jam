class_name MainMenu extends Control

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS  # works even when paused
	$TutoMenu.visible = false

func _on_start_pressed() -> void:
	get_tree().paused = false
	$".".visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_how_to_play_pressed() -> void:
	$TutoMenu.visible = true

func _on_button_pressed() -> void:
	$TutoMenu.visible = false
