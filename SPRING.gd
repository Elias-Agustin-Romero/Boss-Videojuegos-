extends StaticBody2D
signal repel
onready var player = get_parent().get_node('player')
var newPosition

func _physics_process(delta):
	if get_parent().get_children().has(player):
		newPosition = Vector2(player.position.x, 650)
		set_position(newPosition)
		
func _on_Area2D_body_entered(body):
	for body in get_node("Area2D").get_overlapping_bodies():
		if body.get("TYPE") == "PLAYER":
			emit_signal("repel")
