extends "res://abstractEnemy.gd"

func _ready():
	health = 1
	SPEED = 350
	GRAVITY = 800

#This enemy is the die and explode one

func _physics_process(delta):
	pass
	
func die():
	self.boom()
	call_deferred('queue_free')
	
func boom():
	self.shoot(0,1)
	self.shoot(0,-1)
	self.shoot(1,-1)
	self.shoot(1,0)
	self.shoot(-1,-1)
	self.shoot(-1,1)
	self.shoot(1,1)
	self.shoot(-1,0)
