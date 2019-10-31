extends "res://entity.gd"

const SPEED = 400
const GRAVITY = 1600
const DAMAGE = 1

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	movement_loop(delta)
	damage_loop()

func get_input_axis():
	velocity.x = -1
