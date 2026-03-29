class_name SoapPNJ extends CharacterBody2D


var is_player
var player : Player

func open_menu(soap_weapon : Soap):
	$UpgradeMenu.visible = true
	$UpgradeMenu/MarginContainer/Yes.text = "Yes (%d)" % [soap_weapon.price_too_upgrade]
	get_tree().paused = true

func _process(delta: float) -> void:
	if is_player:
		if Input.is_action_just_pressed("Interact"):
			open_menu(player.soap_weapon)

func _on_yes_pressed() -> void:
	var soap_weapon : Soap = player.soap_weapon
	if(player.money < soap_weapon.price_too_upgrade):
		pass
	else:
		player.update_money(-soap_weapon.price_too_upgrade)
		soap_weapon.level_up()
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
