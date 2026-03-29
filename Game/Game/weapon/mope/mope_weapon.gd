class_name Mope
extends Node2D

var weapon_level = 1
var damage = 2
var weapon_scale = Vector2(1,1)
var weapon_speed = 0.2
var knockMult = 1
var price_too_upgrade = 150
var enable = false
@export var player : Player
var mope_projectile : PackedScene = preload("res://Game/weapon/mope/mope_projectile.tscn")

func use_weapon():
	shoot_spread(weapon_level)

func shoot_spread(count: int):
	var base_angle = rad_to_deg(global_position.angle_to_point(get_global_mouse_position()))
	var angle_step = 360.0 / count
	for i in range(count):
		shoot(base_angle + i * angle_step)

func shoot(target_angle):
	var new_projectile : MopeProjectile = mope_projectile.instantiate()
	new_projectile.scale = self.weapon_scale
	new_projectile.damage = self.damage
	new_projectile.rotation_speed = self.weapon_speed
	new_projectile.knockBackStrenghtMult = self.knockMult
	$Projectile.add_child(new_projectile)
	new_projectile.init(target_angle)
	$AudioStreamPlayer2D.play()

func level_up():
	price_too_upgrade += 200
	weapon_level += 1
	if weapon_level == 2:
		knockMult += 1
	if weapon_level == 3:
		knockMult += 1
	if weapon_level == 4:
		weapon_scale += Vector2(0.5, 0.5)
		knockMult += 1

	if weapon_level > 4:
		weapon_scale += Vector2(0.1, 0.1)

func resart():
	weapon_level = 1
	enable = false
	price_too_upgrade = 150
	damage = 2
	weapon_scale = Vector2(1, 1)
	weapon_speed = 0.2
	knockMult = 1
	for child in $Projectile.get_children():
		child.queue_free()
