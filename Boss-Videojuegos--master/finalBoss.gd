extends KinematicBody2D

const DAMAGE = 1
const TYPE = "ENEMY"
onready var player = get_parent().get_node("player")
onready var timer = get_node("Timer")
const projectile_scene = preload("Projectile.tscn")
onready var specialAbility = get_node("finalAttack")

var SPEED = 0
var GRAVITY = 0
var velocity = Vector2(-1, 0)
var knockdir = Vector2()
var hitstun = 0
var health = 10

func _ready():
	SPEED = 200
	GRAVITY = 800
	timer.stop()

func _physics_process(delta):
	var de = delta
	if (get_parent().get_children().has(player) && health!=0 && timer.is_stopped()):
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
		shoot(randf(), randf())
		randomize()

func restart_timer():
	timer.set_wait_time(1)
	timer.start()

func _on_Timer_timeout():
		timer.stop()

func boom():
	self.shoot(0,1)
	self.shoot(0,-1)
	self.shoot(1,-1)
	self.shoot(1,0)
	self.shoot(1,1)
	self.shoot(1,-1)
	self.shoot(-1,-1)
	self.shoot(-1,1)

func shoot(x, y):
	var projectile = projectile_scene.instance()
	projectile.set_type(TYPE)
	get_parent().call_deferred("add_child", projectile)
	projectile.set_position(position)
	projectile.set_projectile_direction_x(x)
	projectile.set_projectile_direction_y(y)

func _on_finalAttack_finished():
	get_tree().quit()