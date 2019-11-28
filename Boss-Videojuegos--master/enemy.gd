extends KinematicBody2D

const DAMAGE = 1
const TYPE = "ENEMY"

var SPEED = 0
var GRAVITY = 0
var velocity = Vector2(-1, 0)
var health = 1

func _ready():
	SPEED = 200
	GRAVITY = 800

func _physics_process(delta):
	move_and_slide(Vector2(-1, GRAVITY * delta) * SPEED, Vector2(0, -1))

func get_input_axis():
	velocity.x = -1

func movement_loop(delta):
#	if hitstun == 0:
	pass
#	else:
#		velocity = knockdir * SPEED * 1.5

func on_projectile_hit(damage):
	queue_free()

func _on_Timer_timeout():
	pass # Replace with function body.
