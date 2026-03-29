class_name SoapProjectile extends CharacterBody2D


var speed = 100

var damage = 1

func _ready() -> void:
	$Bubble.play("Bubble")
	$AnimationPlayer.play("soap_rotation")
const SPEED = 400.0
var direction: Vector2 = Vector2.ZERO



func set_direction(dir: Vector2):
	direction = dir

func _physics_process(delta: float):
	var collision = move_and_collide(direction * SPEED * delta)
	if collision:
		var hit = collision.get_collider()
		if hit.has_method('receive_damage'):
			hit.receive_damage(damage,direction)
		queue_free()
