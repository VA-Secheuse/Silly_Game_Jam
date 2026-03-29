class_name SkateDude extends CharacterBody2D

var speed = 250
var base_speed = 250
var life = 6
var knockback = Vector2.ZERO
var damage = 3

static var ennemie = preload("res://Game/Character/SkateDude/SkateDude.tscn")

func _ready():

	$Sprite2D.material = $Sprite2D.material.duplicate()  
	$Sprite2D.material.set_shader_parameter("flash_color", Color.WHITE)
	$Sprite2D.material.set_shader_parameter("flash_value", 0.0)

func _physics_process(delta):
	# Smoothly reduce knockback each frame
	knockback = knockback.lerp(Vector2.ZERO, 0.2)
	velocity = knockback
	move_and_slide()

static func spawn(vector : Vector2,node : Node):
	var new_ennemie : SkateDude = ennemie.instantiate()
	node.add_child(new_ennemie)
	new_ennemie.global_position = vector

func receive_damage(damage : int, hit_direction: Vector2):
	life -= damage
	knockback = hit_direction * 400 
	if(life <= 0):
		kill()
	var anim = $Sprite2D/AnimationPlayer
	if anim :
		anim.play("Flash")
	

func kill():
	Money.create_and_intantiate(randi_range(50,75),self.global_position,get_parent())
	self.queue_free()
	get_tree().get_root().get_node("MainLevel").add_score(100)


func _on_damage_radius_body_entered(body: Node2D) -> void:
	if body.has_method('receive_damage'):
		body.receive_damage(-damage)
		var direction = (self.global_position - body.global_position).normalized()
		knockback = direction * 400
	
