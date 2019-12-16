extends Node2D

onready var cure = $StatiP1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	cure.set_cure(true)