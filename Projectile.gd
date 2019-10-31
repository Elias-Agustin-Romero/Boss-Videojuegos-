extends Area2D

var FIREBALL_SPEED = 500
var motion
var directionX = 1
var directionY = 0

func _ready():
	set_process(true)

func _process(delta):
	motion = Vector2(directionX, directionY) * FIREBALL_SPEED
	set_position(get_position() + motion * delta)

func set_projectile_direction_x(dir):
	directionX = dir
	
func set_projectile_direction_y(dir):
	directionY = dir

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()

