class_name WaveManager extends Node2D

var cur_wave = 1
var difficulty = 1
var spawn_timer: Timer
var ennemie_array = []

var spawn_node : Node
func _ready():
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.timeout.connect(_spawn_next_enemy)
	spawn_node = $Ennemies

func spawn_wave():
	for ennemie in ennemie_array:
		pass

func next_wave():
	pass

func start_wave():
	generate_wave_array()
	spawn_timer.start()

func generate_wave_array():
	for i in range(difficulty*10 + 10):
		ennemie_array.append(Enemies.new())
	spawn_timer.wait_time = randf_range(0.5, 1.0)

func wave_done():
	difficulty += 1
	cur_wave += 1



func _spawn_next_enemy():
	if ennemie_array.size() == 0:
		spawn_timer.stop()  
		return
	
	var enemy : Enemies = ennemie_array.pop_front()
	Enemies.spawn(_generate_coordinate_out_of_vision(),spawn_node)
	spawn_timer.wait_time = randf_range(0.5, 1.0) 
	spawn_timer.start()

func _generate_coordinate_out_of_vision() -> Vector2:
	var player_pos: Vector2 = $"../..".player.global_position
	var side = randi_range(0, 3)
	var offset = 50  # distance outside screen edge
	
	var viewport_size = get_viewport().get_visible_rect().size / 2
	
	match side:
		0:  # top
			return Vector2(randf_range(player_pos.x - viewport_size.x, player_pos.x + viewport_size.x), player_pos.y - viewport_size.y - offset)
		1:  # bottom
			return Vector2(randf_range(player_pos.x - viewport_size.x, player_pos.x + viewport_size.x), player_pos.y + viewport_size.y + offset)
		2:  # left
			return Vector2(player_pos.x - viewport_size.x - offset, randf_range(player_pos.y - viewport_size.y, player_pos.y + viewport_size.y))
		3:  # right
			return Vector2(player_pos.x + viewport_size.x + offset, randf_range(player_pos.y - viewport_size.y, player_pos.y + viewport_size.y))
	
	return player_pos
