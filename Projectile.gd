extends Area2D

var FIREBALL_SPEED = 500
var motion
var directionX = 1
var directionY = 0
var damage = 1
signal hit
var TYPE = "BULLET"

func _ready():
	connect("body_entered", self, "_on_body_entered")
func _process(delta):
	motion = Vector2(directionX, directionY) * FIREBALL_SPEED
	set_position(get_position() + motion * delta)

func set_projectile_direction_x(dir):
	directionX = dir
	
func set_projectile_direction_y(dir):
	directionY = dir

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()

func _on_body_entered(body):
	if TYPE == "PLAYERBULLET":
		if body.get("TYPE") == "ENEMY":
			body.on_projectile_hit(damage)
			emit_signal("hit")
			call_deferred("queue_free")
	elif TYPE == "ENEMYBULLET":
		if body.get("TYPE") == "PLAYER":
			body.on_projectile_hit(damage)
			emit_signal("hit")
			call_deferred("queue_free")

func set_type(type):
	TYPE = type + TYPE