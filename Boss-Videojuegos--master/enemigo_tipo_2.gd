extends "res://abstractEnemy.gd"
#This enemy is the push and shoot
onready var timer = get_node("Timer")

func _ready():
	health = 2
	SPEED = 200
	GRAVITY = 800
	timer.stop()

func _physics_process(delta):
	move_and_slide(Vector2(-1, GRAVITY * delta) * SPEED, Vector2(0, -1))
	if (timer.is_stopped()):
		shoot(-1,0)
		timer.set_wait_time(1)
		timer.start()
		
func _on_Timer_timeout():
	timer.stop()
		
