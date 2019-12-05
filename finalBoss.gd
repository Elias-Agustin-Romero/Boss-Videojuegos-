extends KinematicBody2D

const DAMAGE = 1
var cross = true
const TYPE = "ENEMY"
onready var main = get_parent().get_parent().get_parent().get_parent()
onready var player = get_parent().get_parent().get_parent().get_parent().get_node('player')
onready var timer = get_node("Timer")
const projectile_scene = preload("Projectile.tscn")
onready var specialAbility = get_node("finalAttack")

var SPEED = 0
var GRAVITY = 0
var velocity = Vector2(-1, 0)
var knockdir = Vector2()
var hitstun = 0
var health = 20

func _ready():
	SPEED = 200
	GRAVITY = 800
	timer.stop()

func _physics_process(delta):
	var de = delta
	if (health!=0 && timer.is_stopped()):
		fire_projectile()
		restart_timer()

func get_input_axis():
	velocity.x = -1

func movement_loop(delta):
#	if hitstun == 0:
	pass
#	else:
#		velocity = knockdir * SPEED * 1.5

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	for body in get_node("hitbox").get_overlapping_bodies():
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = transform.origin - body.transform.origin


func on_projectile_hit(damage):
	boom()
	if health != 0:
		health -= damage
	else:
		specialAbility.play()
		timer.stop()
		set_collision_layer_bit(0, false)
		set_collision_mask_bit(0, false)

func fire_projectile():
	if main.get_children().has(player):
		var enemyToPlayer = (player.global_position - self.global_position).normalized()
		shoot(enemyToPlayer.x, enemyToPlayer.y)
		if health < 10:
			if cross:
				cross()
				cross = false
			else:
				plus()
				cross = true

func restart_timer():
	timer.set_wait_time(1)
	timer.start()

func _on_Timer_timeout():
		timer.stop()

func cross():
	self.shoot(1,-1)
	self.shoot(1,1)
	self.shoot(-1,1)
	self.shoot(-1,-1)
	
func plus():
	self.shoot(0,1)
	self.shoot(0,-1)
	self.shoot(1,0)
	self.shoot(-1,0)

func boom():
	self.plus()
	self.cross()
	self.shoot(0,0)

func shoot(x, y):
	var projectile = projectile_scene.instance()
	projectile.set_type(TYPE)
	main.call_deferred("add_child", projectile)
	projectile.set_position(global_position)
	projectile.set_projectile_direction_x(x)
	projectile.set_projectile_direction_y(y)

func _on_finalAttack_finished():
	get_tree().quit()