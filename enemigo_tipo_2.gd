extends "res://abstractEnemy.gd"
#This enemy is the push and shoot
onready var timer = get_node("Timer")
var dir = -1

func _ready():
	health = 1
	SPEED = 150
	GRAVITY = 200
	$EnemySprite2.visible = true
	timer.stop()

func _physics_process(delta):
	if 	!right.is_colliding():
		right.enabled = true
		left.enabled = true
		dir = -1
	elif 	!left.is_colliding():
		left.enabled = true
		right.enabled = true
		dir = 1
	move_and_slide(Vector2(dir, GRAVITY * delta) * SPEED, Vector2(0, -1))
	if (timer.is_stopped()):
		shoot(-1,0)
		timer.set_wait_time(1)
		timer.start()
		
func _on_Timer_timeout():
	timer.stop()
		
