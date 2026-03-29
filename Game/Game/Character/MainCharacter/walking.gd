extends State

func Update(_delta:float):
	if(Input.get_vector("Left","Right","Up","Down") != Vector2(0,0)):
		$"../..".velocity = Input.get_vector("Left","Right","Up","Down") * $"../..".speed
		$"../..".move_and_slide()
	##Side the sprite Looks
	if ($"../..".velocity.x > 0 && $"../../Sprite2D".flip_h != false ):
		$"../../Sprite2D".flip_h = false
		$"../../Weapons/Detergent".flip_h_false()
	if ($"../..".velocity.x < 0 && $"../../Sprite2D".flip_h != true):
		$"../../Sprite2D".flip_h = true
		$"../../Weapons/Detergent".flip_h_true()

	else:
		Transitioned.emit(self,"Idle") 
