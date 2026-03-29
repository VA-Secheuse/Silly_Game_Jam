class_name MainLevel extends Node2D

@export var player : Player 


var is_running
var elapsed_time: float = 0.0


func _ready() -> void:
	$YSort/RobinTown/MainMenu.visible = true
	pause_game()
	$YSort/WaveManage.start_wave()
	is_running = true
	$WaveTimer.start()

func _process(delta: float) -> void:
	if not is_running:
		return
	elapsed_time += delta
	player.update_display(elapsed_time)
	if Input.is_action_just_pressed("Pause"):
		pause_game()
		$YSort/RobinTown/PauseMenu.visible = true

func _on_wave_timer_timeout() -> void:
	$PauseTimer.start()


func _on_pause_timer_timeout() -> void:
	$YSort/WaveManage.next_wave()
	$WaveTimer.start()

func add_score(number : int):
	player.update_score(number)

func pause_game():
	get_tree().paused = true
