extends Position2D

signal final_showdown
onready var player = get_parent().get_node('player')
var newPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if position.x < 9512:
		if get_parent().get_children().has(player):
			#newPosition = Vector2(min(9000, max(player.position.x, self.position.x)),0)
			newPosition = Vector2(max(player.position.x, self.position.x),0)
			set_position(newPosition)
	else:
		emit_signal('final_showdown')
