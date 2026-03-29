class_name Soap
extends Node2D



var weapon_level = 1

var price_too_upgrade = 100

var projectile_damage = 1

var projectile_scale = Vector2(1,1)



@export var player : Player

static var soap_projectile = preload("res://Game/weapon/soap/soap_projectile.tscn")

var second_projectile_timer: Timer 

func _ready():
	second_projectile_timer = Timer.new()
	add_child(second_projectile_timer)
	second_projectile_timer.timeout.connect(_on_second_projectile_timeout)
	second_projectile_timer.one_shot = true
	second_projectile_timer.wait_time = 0.5

func restart():
	weapon_level = 1
	price_too_upgrade = 100
	projectile_damage = 1
	projectile_scale = Vector2(1,1)

func use_weapon():
	match weapon_level:
		1:
			shoot(player.global_position,get_global_mouse_position())
		2:
			shoot_spread(player.global_position,get_global_mouse_position(),2,90)
		3:
			shoot_spread(player.global_position,get_global_mouse_position(),4,90)
		4:
			shoot_spread(player.global_position,get_global_mouse_position(),4,90)
			second_projectile_timer.start()
		var n when n >= 5: 
			shoot_spread(player.global_position, get_global_mouse_position(), 4, 90)
			second_projectile_timer.start()
		_:
			pass

func shoot_spread(position: Vector2, toward: Vector2, count: int, spread_degrees: float):
	var base_direction = position.direction_to(toward)
	var base_angle = base_direction.angle()
	var start_angle = base_angle - deg_to_rad(spread_degrees)
	
	var step = deg_to_rad(spread_degrees)  
	for i in range(count):
		var angle = start_angle + step * i
		var direction = Vector2(cos(angle), sin(angle))
		spawn_projectile(position, direction)

func spawn_projectile(position: Vector2, direction: Vector2):
	var new_projectile: SoapProjectile = soap_projectile.instantiate()
	get_tree().get_root().get_node('MainLevel/YSort/Projectile').add_child(new_projectile)
	new_projectile.global_position = position
	new_projectile.set_direction(direction)
	new_projectile.scale = self.projectile_scale
	new_projectile.damage = self.projectile_damage

func shoot(position: Vector2,toward : Vector2):
	var new_projectile: SoapProjectile = soap_projectile.instantiate()
	var direction = position.direction_to(toward)
	get_tree().get_root().get_node('MainLevel/YSort/Projectile').add_child(new_projectile)
	new_projectile.global_position = position
	new_projectile.set_direction(direction)
	new_projectile.scale = self.projectile_scale
	new_projectile.damage = self.projectile_damage

func level_up():
	weapon_level +=1
	price_too_upgrade += 100
	if self.weapon_level > 3:
		self.projectile_damage +=1
	if self.weapon_level > 4:
		self.projectile_scale += Vector2(0.5,0.5)


func _on_second_projectile_timeout() -> void:
	if weapon_level < 5 :
		shoot(player.global_position,get_global_mouse_position())
	else:
		shoot_spread(player.global_position,get_global_mouse_position(),3,30)
