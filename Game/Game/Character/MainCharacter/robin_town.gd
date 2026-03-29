class_name Player extends CharacterBody2D

@export var speed = 400

var money = 6000

var life = 2

var score = 0

@export var i_frame = false

@export var soap_weapon : Soap 

@export var mainLevel : MainLevel

func _ready() -> void:
	update_score(score)
	$Camera2D/UI.move_to_front()

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Action")):
		$Weapons/Soap.use_weapon()

func restart():
	money = 6000
	life = 10 
	score = 0
	update_score(score)
	$Weapons/Soap.restart()
	

func update_display(elapsed_time):
	var minutes = int(elapsed_time) / 60
	var seconds = int(elapsed_time) % 60
	$Camera2D/UI/time.text = "%02d:%02d" % [minutes, seconds]

func update_money(add_or_remove_money):
	money += add_or_remove_money
	$Camera2D/UI/money.text = "%02d$" % [money]

func update_score(add_score):
	score += add_score
	$Camera2D/UI/Score.text = "Score : %00000d" % [score]

func receive_damage(life_change : int):
	if !i_frame:
		i_frame = true
		life += life_change
		$Sprite2D/AnimationPlayer.play("flash")
	if(life <=0):
		mainLevel.death_screen()
		
