class_name Enemies extends CharacterBody2D

var speed = 25
var life = 5
var knockback = Vector2.ZERO

static var ennemie = preload("res://Game/Character/Alex/alex.tscn")

func _ready():
	# make material unique to this instance
	$Sprite2D.material = $Sprite2D.material.duplicate()  # ← key fix
	$Sprite2D.material.set_shader_parameter("flash_color", Color.WHITE)
	$Sprite2D.material.set_shader_parameter("flash_value", 0.0)

func _physics_process(delta):
	# Smoothly reduce knockback each frame
	knockback = knockback.lerp(Vector2.ZERO, 0.2)
	velocity = knockback
	move_and_slide()

static func spawn(vector : Vector2,node : Node):
	var new_ennemie : Enemies = ennemie.instantiate()
	node.add_child(new_ennemie)
	new_ennemie.global_position = vector

func receive_damage(damage, hit_direction: Vector2):
	life = life - damage
	knockback = hit_direction * 200 
	if(life <= 0):
		kill()
	var anim = $Sprite2D/AnimationPlayer
	if anim :
		anim.play("Flash")
	

func kill():
	Money.create_and_intantiate(randi_range(5,10),self.global_position,get_parent())
	self.queue_free()
