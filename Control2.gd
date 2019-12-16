extends Node

func paused():
	$HBoxContainer/Resume.visible  = true
	$HBoxContainer.visible = true


func restart():
	$HBoxContainer/Congratulations.visible = false
	$HBoxContainer.visible = true
	$HBoxContainer/Resume.visible = false

func unpaused():
	$HBoxContainer.visible = false

func restarted():
	$HBoxContainer.visible = false	
	
func boss_died():
	$HBoxContainer/Congratulations.visible = true
	$HBoxContainer.visible = true
	$HBoxContainer/Resume.visible  = false
	