extends Area2D

onready var player = get_parent().get_parent().get_node('player')
var newPosition

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if get_parent().get_parent().get_children().has(player):
		newPosition = Vector2(player.position.x, 550)
		set_position(newPosition)
		