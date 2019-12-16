extends StaticBody2D
onready var isCure = false
onready var is_ghost = false

func _ready():
	if isCure:
		$Cura.visible = true
	else:
		$Sprite.visible = true

func _on_hitbox_body_entered(body):
	for body in get_node("hitbox").get_overlapping_bodies():
		if body.get("TYPE") == "PLAYER":
			if isCure and body.health < 5:
				body.cure()
				set_cure(false)
				$Cura.visible = false
				$Sprite.visible = true
			elif is_ghost:
				$Sprite.visible = false
				$Ghost.visible = true
				$Animation.play("ghost")
				call_deferred('CollisionShape2D.set_disabled', true)
				call_deferred('hitbox/CollisionShape2D.set_disabled', true)
			else:
				print("NO ghost")
		
func make_ghost():
	is_ghost = true

func set_cure(boolean):
	isCure = boolean
	$Cura.visible = boolean
	$Sprite.visible = !boolean
	
	
