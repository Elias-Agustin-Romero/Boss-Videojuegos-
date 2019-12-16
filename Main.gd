extends Node

onready var nivelA = preload("NivelA.tscn")
onready var nivelB = preload("NivelB.tscn")
onready var nivelC = preload("NivelC.tscn")
onready var nivelD = preload("NivelD.tscn")
onready var nivelE = preload("NivelE.tscn")
onready var nivelF = preload("NivelF.tscn")

func _process(delta):
	if Input.is_action_just_pressed("pause") && not get_tree().paused:
		get_tree().paused = not get_tree().paused
		get_node("Position2D/Node").paused()

func _ready():
	_instance_levels()		

func _instance_levels():
	var order = __shuffleList([nivelA, nivelB, nivelC, nivelD, nivelE, nivelF])
	var place = [$Nivel1,$Nivel2, $Nivel3, $Nivel4, $Nivel5]
	for level in 5:
		var node = order[level].instance()
		node.inicializate(level)
		place[level].add_child(node)
		
func __shuffleList(list):
    var shuffledList = []
    var indexList = range(list.size())
    for i in range(list.size()):
        randomize()
        var x = randi()%indexList.size()
        shuffledList.append(list[x])
        indexList.remove(x)
        list.remove(x)
    return shuffledList


func _on_Position2D_final_showdown():
	if (!get_node("NivelBoss").has_node('Path2D')):
		$backgroundMusic.stop()
		$bossMusic.play(0)
		var jefe_appears = preload('jefe_appears.tscn')
		get_node("NivelBoss").add_child(jefe_appears.instance())


func _on_player_player_died():
	get_node("Position2D/Node").restart()


func _on_Button_pressed():
	get_tree().reload_current_scene()


func _on_resume_pressed():
	get_tree().paused = not get_tree().paused
	$Position2D/Node.unpaused() 


func _on_restart_pressed():
	get_tree().paused = false
	$Position2D/Node.restarted() 
	get_tree().reload_current_scene()


func _on_exit_pressed():
	get_tree().quit()
