extends StaticBody2D
onready var isCure = false
onready var is_ghost = false
	
func _on_hitbox_body_entered(body):
	if isCure:
		$Cura.visible = true
		for body in get_node("hitbox").get_overlapping_bodies():
			if body.get("TYPE") == "PLAYER" and body.health < 5:
				body.cure()
				set_cure(false)
				$Cura.visible = false
				
	elif is_ghost:
		$Sprite.visible = true
		for body in get_node("hitbox").get_overlapping_bodies():
			if body.get("TYPE") == "PLAYER":
				$Sprite.visible = false
				$Ghost.visible = true
				$Animation.play("ghost")
				$CollisionShape2D.set_disabled(true)
				$hitbox/CollisionShape2D.set_disabled(true)
	else:
		$Sprite.visible = true
		
func make_ghost():
	self.is_ghost = true

func set_cure(boolean):
	isCure = boolean
