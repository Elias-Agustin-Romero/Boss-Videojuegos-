extends AnimationPlayer
var b = true

func _on_Area2D_body_entered(body):
	if b:
		self.play("Nueva animación")
		b=false
