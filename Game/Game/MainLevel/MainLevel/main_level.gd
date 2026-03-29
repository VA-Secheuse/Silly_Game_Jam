class_name MainLevel extends Node2D

@export var player : Player 


var is_running

var elapsed_time: float = 0.0

var highScore : int = 0


func _ready() -> void:
	$YSort/RobinTown/MainMenu.visible = true
	pause_game()
	$YSort/WaveManage.start_wave()
	is_running = true
	$WaveTimer.start()
	$YSort/RobinTown.position = $SpawnPosition.position

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

func restart():
	delete_all_children($YSort/WaveManage/Ennemies)
	delete_all_children($YSort/Projectile)
	$YSort/WaveManage.restart()
	elapsed_time = 0.0
	$YSort/WaveManage.start_wave()
	is_running = true
	$WaveTimer.start()
	$YSort/RobinTown.restart()
	$YSort/RobinTown.position = $SpawnPosition.position

func delete_all_children(parent_node):
	var children = parent_node.get_children()
	for child in children:
		child.queue_free()

func death_screen():
	$YSort/RobinTown/GameOverScreen.visible = true
	$YSort/RobinTown/GameOverScreen.open_game_over_screen(player.score,highScore)
	if(player.score > highScore) :
		highScore = player.score
	self.restart()
	get_tree().paused = true
