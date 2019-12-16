extends "res://abstractEnemy.gd"
#This enemy is the push and shoot
onready var main = get_parent().get_parent().get_parent().get_parent().get_parent()
onready var player = main.get_node('player')
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
		fire_projectile()
		timer.set_wait_time(1)
		timer.start()

func fire_projectile():
	if main.get_children().has(player):
		var enemyToPlayer = (player.global_position - self.global_position).normalized()
		shoot(enemyToPlayer.x, enemyToPlayer.y)

func _on_Timer_timeout():
	timer.stop()
		
