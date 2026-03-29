class_name WaveManager extends Node2D

var cur_wave = 1
var difficulty = 1
var spawn_timer: Timer
var ennemie_array = []

@export var spawn_node : Node
func _ready():
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.wait_time = 0.25
	spawn_timer.timeout.connect(_spawn_next_enemy)

func restart():
	difficulty =1
	ennemie_array = []
	cur_wave = 1
	spawn_timer.free()
	_ready()
	

func spawn_wave():
	for ennemie in ennemie_array:
		pass

func next_wave():
	wave_done()
	generate_wave_array()
	_spawn_next_enemy()

func start_wave():
	generate_wave_array()
	spawn_timer.start()
	

func generate_wave_array():
	var max_small = 60
	var cur_small = difficulty*10 +10
	if cur_small > max_small:
		cur_small = 60
	for i in range(cur_small):
		ennemie_array.append(1)
	if(difficulty > 3):
		for i in range((difficulty-3) *2):
			ennemie_array.append(2)
	if(difficulty > 6):
		for i in range((difficulty-6) * 2):
			ennemie_array.append(3)
	ennemie_array.shuffle()
	spawn_timer.wait_time = randf_range(0.5, 1.0)

func wave_done():
	difficulty += 1
	cur_wave += 1



func _spawn_next_enemy():
	if ennemie_array.size() == 0:
		spawn_timer.stop()  
		return
	
	
	var enemy = ennemie_array.pop_front()
	
	match enemy:
		1:
			Enemies.spawn(_generate_coordinate_out_of_vision(),spawn_node)
		2:
			Rouly.spawn(_generate_coordinate_out_of_vision(),spawn_node) 
		3:
			SkateDude.spawn(_generate_coordinate_out_of_vision(),spawn_node)
		_:
			pass
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
