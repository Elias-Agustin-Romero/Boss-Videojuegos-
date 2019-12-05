extends "res://abstractEnemy.gd"
#This enemy is the poop bullets one
onready var timer = get_node("Timer")

func _ready():
	health = 1
	SPEED = 250
	GRAVITY = 0
	$EnemySprite3.visible = true
	var posision = Vector2(get_global_position().x, rand_range(200,400))
	set_global_position(posision)
	set_collision_layer_bit(5,true)
	set_collision_mask_bit(0,false)
	set_collision_mask_bit(5,true)

export var max_speed = 300
export var vertical_speed = 500

var screensize
var vel = Vector2()


func _physics_process(delta):
	vel.y = cos(get_global_position().x * delta) * 700
	vel.x = SPEED
	vel.x =  -clamp(vel.x, -SPEED, SPEED)
	var movement = move_and_slide(vel)
	if(timer.is_stopped()):
		shoot(0,0)
		timer.set_wait_time(0.15)
		timer.start()

#func _physics_process(delta):
#	move_and_slide(Vector2(-1, GRAVITY * delta) * SPEED, Vector2(0, -1))
#	if (timer.is_stopped()):
#		shoot(0,0)
#		timer.set_wait_time(0.15)
#		timer.start()
		
func _on_Timer_timeout():
	timer.stop()