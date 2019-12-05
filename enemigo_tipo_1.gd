extends "res://abstractEnemy.gd"

func _ready():
	health = 1
	SPEED = 350
	GRAVITY = 800
	$EnemySprite1.visible = true

#This enemy is the die and explode one

func _physics_process(delta):
	move_and_slide(Vector2(0, GRAVITY * delta) * SPEED, Vector2(0, -1))
	
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
