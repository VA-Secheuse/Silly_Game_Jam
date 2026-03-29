class_name Item extends Node2D

var scene_path : String

func create_and_instantiate() -> Item:
	var scene : PackedScene = load(scene_path)
	var new_item = scene.instantiate()
	return new_item

func flip_item_left():
	$GrabPosition/Sprite2D.flip_h = false

func flip_item_right():
	$GrabPosition/Sprite2D.flip_h = true
