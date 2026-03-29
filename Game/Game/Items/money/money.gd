class_name Money extends Node2D

var amount

static var money : PackedScene = preload("res://Game/Items/money/money.tscn")

func create(amount):
	var new_money = Money.new()
	new_money.amount = amount
	return new_money

static func create_and_intantiate(amount : int,position : Vector2,node : Node):
	var new_money : Money = money.instantiate()
	new_money.amount = amount
	node.add_child(new_money)
	new_money.global_position = position

func _on_area_2d_body_entered(body: Node2D) -> void:
	var player = body.get_parent()
	if body.has_method('update_money'):
		body.update_money(amount)
		get_tree().get_root().get_node("MainLevel").add_score(amount)
	self.queue_free()
