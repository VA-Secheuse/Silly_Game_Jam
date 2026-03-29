class_name Attack extends State

var level: MainLevel
var player :Player
var direction


func Enter():
	level  = get_tree().current_scene
	player  = level.player

func Update(_delta:float):
	move_to(player.position)
	$"../..".move_and_slide()

func move_to(vector : Vector2):
	$"../..".velocity = $"../..".position.direction_to(vector) * $"../..".speed
