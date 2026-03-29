class_name DetergentNPC extends CharacterBody2D


var is_player
var player : Player

func open_menu(Det_weapon : DetergentWeapon):
	if(Det_weapon.enable == false):
		$UpgradeMenu.visible = true
		$UpgradeMenu/MarginContainer/Label.text = ('Do you want to 
												unlock the detergent ability ?')
		$UpgradeMenu/MarginContainer/Yes.text = "Yes (%d)" % [Det_weapon.price_too_upgrade]
	else:
		$UpgradeMenu/MarginContainer/Label.text = ('Do you want to 
												upgrade your the detergent ability ?')
		$UpgradeMenu.visible = true
		$UpgradeMenu/MarginContainer/Yes.text = "Yes (%d)" % [Det_weapon.price_too_upgrade]
	get_tree().paused = true

func _process(delta: float) -> void:
	if is_player:
		if Input.is_action_just_pressed("Interact"):
			open_menu(player.detergent_weapon)

func _on_yes_pressed() -> void:
	var det : DetergentWeapon = player.detergent_weapon
	if(player.money < det.price_too_upgrade):
		pass
	else:
		if(det.enable == false):
			det.enable = true
			player.update_money(-det.price_too_upgrade)
			player.detergent_weapon.start_dropping()
		else :
			det.level_up()
			player.update_money(-det.price_too_upgrade)
		
		$UpgradeMenu.visible = false
		get_tree().paused = false


func _on_no_pressed() -> void:
	$UpgradeMenu.visible = false
	get_tree().paused = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method('update_display'):
		is_player = true	
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	is_player = false
	player = null
