extends Node2D

# Declare member variables here. Examples:
onready var player = get_parent().get_node("player")
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if get_parent().has_node("player"):
		position.x = max(position.x, player.position.x)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
