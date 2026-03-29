class_name DetergentProjectile
extends Area2D

var damage = 1
var speed_boost : float = 500
var speed_debuff : float = 90
var damage_tick : float = 1.0
var ennemie_inside = []
var timer : Timer

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = damage_tick
	timer.one_shot = false
	timer.timeout.connect(_on_damage_tick_timeout)
	$Dispawn.start()
	add_child(timer)
	timer.start()

func set_damage_tick(i: float):
	damage_tick = i
	timer.wait_time = damage_tick

func _on_body_entered(body: Node2D) -> void:
	if body.has_method('spawn'):
		ennemie_inside.append(body)
		body.speed = speed_debuff
	if body.has_method('update_money'):
		body.speed = speed_boost

func _on_body_exited(body: Node2D) -> void:
	if body.has_method('spawn'):
		ennemie_inside.erase(body)
		body.speed = body.base_speed
	if body.has_method('update_money'):
		body.speed = body.base_speed

func _on_damage_tick_timeout() -> void:
	for ennemie in ennemie_inside:
		if ennemie.has_method('receive_damage'):
			ennemie.receive_damage(damage, Vector2(0, 0))


func _on_dispawn_timeout() -> void:
	self.queue_free()
