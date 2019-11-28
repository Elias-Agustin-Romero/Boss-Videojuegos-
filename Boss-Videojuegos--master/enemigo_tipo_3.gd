extends "res://abstractEnemy.gd"
#This enemy is the poop bullets one
onready var timer = get_node("Timer")

func _ready():
	health = 3
	SPEED = 200
	GRAVITY = 800
	
func _physics_process(delta):
	move_and_slide(Vector2(-1, GRAVITY * delta) * SPEED, Vector2(0, -1))
	if (timer.is_stopped()):
		shoot(0,0)
		timer.set_wait_time(0.15)
		timer.start()
		
func _on_Timer_timeout():
	timer.stop()