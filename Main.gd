extends Node

onready var nivelA = preload("NivelA.tscn")
onready var nivelB = preload("NivelB.tscn")
onready var nivelC = preload("NivelC.tscn")
onready var nivelD = preload("NivelD.tscn")
onready var nivelE = preload("NivelE.tscn")
onready var nivelF = preload("NivelF.tscn")

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
	get_node('Position2D/Camera2D/Control').visible = true


func _on_Button_pressed():
	get_node('Position2D/Camera2D/Control').visible = false
	get_tree().reload_current_scene()
