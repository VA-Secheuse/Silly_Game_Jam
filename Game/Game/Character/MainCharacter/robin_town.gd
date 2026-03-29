class_name Player extends CharacterBody2D

@export var speed = 400

var base_speed = 400
var money = 0

var life = 10

var score = 0

@export var i_frame = false

@export var soap_weapon : Soap 

@export var mope_weapon : Mope

@export var detergent_weapon : DetergentWeapon

@export var mainLevel : MainLevel

func _ready() -> void:
	update_score(score)
	update_money(money)
	$Camera2D/UI.move_to_front()
	$Weapons/Soap2.start()
	$Weapons/Mope2.start()
	$mainMusic.play()
	$Camera2D/UI/MarginContainer/Label.text = str(life)
	



func restart():
	money = 0
	life = 10 
	score = 0
	update_score(score)
	$Weapons/Soap.restart()
	$Weapons/Mope.resart()
	$Weapons/Detergent.restart()
	$Camera2D/UI/MarginContainer/Label.text = str(life)

func update_display(elapsed_time):
	var minutes = int(elapsed_time) / 60
	var seconds = int(elapsed_time) % 60
	$Camera2D/UI/time.text = "%02d:%02d" % [minutes, seconds]

func update_money(add_or_remove_money):
	money += add_or_remove_money
	$cash.play()
	$Camera2D/UI/money.text = "%02d$" % [money]

func update_score(add_score):
	score += add_score
	$Camera2D/UI/Score.text = "Score : %00000d" % [score]

func receive_damage(life_change : int):
	if !i_frame:
		i_frame = true
		life += life_change
		$Sprite2D/AnimationPlayer.play("flash")
		$Camera2D/UI/MarginContainer/Label.text = str(life)
		$Hurt.play()
	if(life <=0):
		mainLevel.death_screen()
		


func _on_soap_2_timeout() -> void:
	soap_weapon.use_weapon()


func _on_mope_2_timeout() -> void:
	if mope_weapon.enable  == true:
		mope_weapon.use_weapon()

func interact_true():
	$Exclamation.visible = true

func interact_false():
	$Exclamation.visible = false
	
