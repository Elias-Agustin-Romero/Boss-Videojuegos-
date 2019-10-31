extends KinematicBody2D

var SPEED = 0
var GRAVITY = 0
const TYPE = "ENEMY"

var velocity = Vector2(0, 0)
var knockdir = Vector2()
var hitstun = 0
var health = 1

func movement_loop(delta):
	if hitstun == 0:
		get_input_axis()
		velocity.y += GRAVITY * delta
		velocity = velocity * SPEED
	else:
		velocity = knockdir * SPEED * 1.5
	move_and_slide(velocity, Vector2(0, -1))

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	for body in get_node("hitbox").get_overlapping_bodies():
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = self.transform.origin - body.transform.origin

func get_input_axis():
	pass
