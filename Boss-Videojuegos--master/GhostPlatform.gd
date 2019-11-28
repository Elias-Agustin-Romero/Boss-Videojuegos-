extends StaticBody2D

signal signActivate

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	for body in get_node("hitbox").get_overlapping_bodies():
		if body.get("TYPE") == "PLAYER":
			$Animation.play("ghost")
			emit_signal("signActivate")
		$CollisionShape2D.set_disabled(true)