extends KinematicBody2D

const DAMAGE = 1
const TYPE = "ENEMY"

var SPEED = 0
var GRAVITY = 0
var velocity = Vector2(-1, 0)
var knockdir = Vector2()
var hitstun = 0
var health = 1

func _ready():
	SPEED = 200
	GRAVITY = 800

func _physics_process(delta):
#	movement_loop(delta)
	#damage_loop()
	move_and_slide(Vector2(-1, GRAVITY * delta) * SPEED, Vector2(0, -1))

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
	queue_free()