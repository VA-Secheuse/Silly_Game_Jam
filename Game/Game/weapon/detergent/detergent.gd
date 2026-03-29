class_name DetergentWeapon extends Node2D

var pool : PackedScene = preload("res://Game/weapon/detergent/detergent_projectile.tscn")

@export var player : Player

var weapon_level = 1

var price_too_upgrade = 150

var damage = 1
var speed_boost : float = 500
var speed_debuff : float = 90
var damage_tick : float = 5

var dropping_time : float = 2
var dropping_wait : float = 5

var dropping = false

var is_dropping = false

var enable = false

func restart():
	$DroppingWait.stop()
	$DroppingTime.stop()
	$Spacing.stop()
	damage = 1
	enable = false
	dropping = false
	is_dropping = false
	speed_boost= 500
	speed_debuff = 90
	damage_tick = 5
	dropping_time = 2
	dropping_wait = 5
	weapon_level = 1
	price_too_upgrade = 150
	set_dropping_time(dropping_time)
	set_dropping_wait(dropping_wait)

func start_dropping():
	$DroppingTime.start()

func _process(delta: float) -> void:
	if dropping && !is_dropping :
		drop_pool()
		$Spacing.start()
		is_dropping = true

func level_up():
	weapon_level += 1
	price_too_upgrade += 100
	if(weapon_level ==2) :
		dropping_time += 1
		speed_debuff -= 10
		set_dropping_time(dropping_time)
	if(weapon_level ==3) :
		dropping_wait -=1
		speed_boost += 100
		speed_debuff -= 10
		set_dropping_wait(dropping_wait)
	else:
		dropping_time += 0.5
		set_dropping_time(dropping_time)
		
	
	
func drop_pool():
	var new_pool : DetergentProjectile  = pool.instantiate()
	new_pool.damage = self.damage
	new_pool.speed_boost = self.speed_boost
	new_pool.speed_debuff = self.speed_debuff
	get_tree().get_root().get_node('MainLevel/YSort/Projectile').add_child(new_pool)
	new_pool.set_damage_tick(damage_tick)
	new_pool.global_position = player.global_position


func _on_spacing_timeout() -> void:
	is_dropping = false


func _on_dropping_wait_timeout() -> void:
	dropping = true
	$DroppingTime.start()
	$Sprite2D.visible = true
	$AudioStreamPlayer2D.play()

func set_dropping_wait(i):
	$DroppingWait.wait_time = i

func set_dropping_time(i):
	$DroppingTime.wait_time = i

func flip_h_true():
	$Sprite2D.flip_v = true

func flip_h_false():
	$Sprite2D.flip_v = false

func _on_dropping_time_timeout() -> void:
	dropping = false
	$Sprite2D.visible = false
	$DroppingWait.start()
