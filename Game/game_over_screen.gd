class_name GameOver extends Control

@export var main_game : MainLevel

func open_game_over_screen(score : int, highScore : int):
	if(score > highScore) : 
		$MarginContainer/VBoxContainer/Score.text = " NEW HIGHSCORE : \n %d !!"  % [score]
		$MarginContainer/VBoxContainer/HighScore.text = "" 
	else :
		$MarginContainer/VBoxContainer/Score.text = "Score : %d" % [score]
		$MarginContainer/VBoxContainer/HighScore.text = "HighScore : %d" % [highScore]


func _on_continue_pressed() -> void:
	main_game.restart()
	self.visible = false
	get_tree().paused = false


func _on_quit_pressed() -> void:
	get_tree().quit()
