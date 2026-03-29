class_name MainLevel extends Node2D

@export var player : Player 


var current_wave = 0
var is_running
var elapsed_time: float = 0.0

func _ready() -> void:
	$YSort/WaveManage.start_wave()
	is_running = true


func _process(delta: float) -> void:
	if not is_running:
		return
	elapsed_time += delta
	player.update_display(elapsed_time)
