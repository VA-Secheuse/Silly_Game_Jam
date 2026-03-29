class_name Stick extends Item


func _init() -> void:
	scene_path = "res://Game/Items/Stick/stick.tscn"

func main_action():
	$AnimationPlayer.play("strike")

func return_to_normal_postion():
	$GrabPosition.rotation = 0
