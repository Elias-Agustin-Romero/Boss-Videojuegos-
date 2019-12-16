extends Control

func _on_exit_pressed():
	get_tree().quit()


func _on_start_pressed():
	get_tree().change_scene("res://Main.tscn")


func _on_start_mouse_entered():
	$CenterContainer/HBoxContainer/VBoxContainer/Sprite2.visible = true


func _on_exit_mouse_entered():
	$CenterContainer/HBoxContainer/VBoxContainer2/Sprite.visible = true


func _on_exit_mouse_exited():
	$CenterContainer/HBoxContainer/VBoxContainer2/Sprite.visible = false


func _on_start_mouse_exited():
	$CenterContainer/HBoxContainer/VBoxContainer/Sprite2.visible = false
