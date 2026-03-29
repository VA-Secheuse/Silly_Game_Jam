class_name Soap
extends Node2D



var weapon_level = 1

@export var player : Player

static var soap_projectile = preload("res://Game/weapon/soap/soap_projectile.tscn")

func use_weapon():
	match weapon_level:
		1:
			shoot(player.global_position)
		_:
			pass

func shoot(position: Vector2):
	var new_projectile: SoapProjectile = soap_projectile.instantiate()
	var direction = position.direction_to(get_global_mouse_position())
	get_tree().current_scene.add_child(new_projectile)
	new_projectile.global_position = position
	new_projectile.set_direction(direction)
