class_name MopeProjectile
extends Node2D

var rotation_speed = 0.2
var damage = 2
var end = false
var start_angle = 0
var knockBackStrenghtMult = 2

func init(angle_deg: float):
	start_angle = angle_deg - 30
	global_position += Vector2.from_angle(deg_to_rad(angle_deg)) * 30
	$RotationOffset.rotation = deg_to_rad(start_angle)

func rotate_projectile():
	if end:
		return

	var target_rad = deg_to_rad(start_angle + 180)
	
	# always rotate in the positive direction (counterclockwise)
	if $RotationOffset.rotation < target_rad:
		$RotationOffset.rotation += rotation_speed
	else:
		end = true
		$RotationOffset.rotation = target_rad
		await get_tree().create_timer(0.2).timeout
		queue_free()

func _process(delta: float) -> void:
	rotate_projectile()

func _on_character_body_2d_body_entered(body: Node2D) -> void:
	if body.has_method('receive_damage'):
		var hit_direction = -$RotationOffset.transform.y
		body.receive_damage(damage, hit_direction)
		body.knockback *= knockBackStrenghtMult
