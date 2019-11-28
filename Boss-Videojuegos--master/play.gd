extends "res://entity.gd"

const SPEED = 70
const GRAVITY = 1600

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	controls_loop()
	movement_loop(delta)

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	
