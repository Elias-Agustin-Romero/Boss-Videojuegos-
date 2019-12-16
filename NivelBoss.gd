extends Node2D

func _ready():
	get_children()[0].set_cure(true)

func _on_Timer_timeout():
	$Cure.set_cure(true)
	$Timer.start()

func boss_died():
	get_parent().get_node("Position2D/Node").boss_died()