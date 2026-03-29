class_name MopPNJ extends CharacterBody2D


var is_player
var player : Player

func open_menu(mop : Mope):
	if(mop.enable == false):
		$UpgradeMenu.visible = true
		$UpgradeMenu/MarginContainer/Label.text = ('Do you want to 
												unlock the mop ability ?')
		$UpgradeMenu/MarginContainer/Yes.text = "Yes (%d)" % [mop.price_too_upgrade]
	else:
		$UpgradeMenu/MarginContainer/Label.text = ('Do you want to 
												upgrade your mop ability ?')
		$UpgradeMenu.visible = true
		$UpgradeMenu/MarginContainer/Yes.text = "Yes (%d)" % [mop.price_too_upgrade]
	get_tree().paused = true
func _process(delta: float) -> void:
	if is_player:
		if Input.is_action_just_pressed("Interact"):
			open_menu(player.mope_weapon)

func _on_yes_pressed() -> void:
	var mop : Mope = player.mope_weapon
	if(player.money < mop.price_too_upgrade):
		pass
	else:
		if(mop.enable == false):
			mop.enable = true
			player.update_money(-mop.price_too_upgrade)
		else :
			mop.level_up()
			player.update_money(-mop.price_too_upgrade)
		
		$UpgradeMenu.visible = false
		get_tree().paused = false


func _on_no_pressed() -> void:
	$UpgradeMenu.visible = false
	get_tree().paused = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method('update_display'):
		is_player = true
		if(body.has_method('interact_true')):
			body.interact_true()
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	is_player = false
	player = null
	if(body.has_method('interact_false')):
			body.interact_false()
