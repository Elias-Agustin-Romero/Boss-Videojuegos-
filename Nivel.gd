extends Node2D

const enemy0 = preload("res://enemy.tscn")
const enemy1 = preload("res://enemigo_tipo_1.gd")
const enemy2 = preload("res://enemigo_tipo_2.gd")
const enemy3 = preload("res://enemigo_tipo_3.gd")

func consegui_hijos():
	var n=[]
	for c in $normales.get_children():
   		if c is Node2D:
        n.append(c)
	return n
	
func murder():#Cause it makes ghosts
	for node in $fantasmas.get_children():
		for body in node.get_children():
				body.make_ghost()
				
func cura():#Cause it makes ghosts
	var lista = []
	for node in $normales.get_children():
		for body in node.get_children():
				lista.append(body)
	return lista

func inicializate(num):
	murder()
	randomize()
	var n = clamp(randi(), 0, 6)
	var points = __shuffleList(consegui_hijos())
	var plataformaDeCura = cura()
	plataformaDeCura[n].set_cure(true)
	match num:
		0:
			__add_enemy_to_point(points[0], enemy1)
			__add_enemy_to_point(points[1], enemy1)
			__add_enemy_to_point(points[2], enemy2)
		1:
			__add_enemy_to_point(points[0], enemy1)
			__add_enemy_to_point(points[1], enemy1)
			__add_enemy_to_point(points[2], enemy2)
			__add_enemy_to_point(points[3], enemy2)
		2:
			__add_enemy_to_point(points[0], enemy1)
			__add_enemy_to_point(points[1], enemy2)
			__add_enemy_to_point(points[2], enemy2)
			__add_enemy_to_point(points[3], enemy3)
		3:
			__add_enemy_to_point(points[0], enemy1)
			__add_enemy_to_point(points[1], enemy1)
			__add_enemy_to_point(points[2], enemy2)
			__add_enemy_to_point(points[3], enemy2)
			__add_enemy_to_point(points[4], enemy3)
			__add_enemy_to_point(points[5], enemy3)
		4:
			__add_enemy_to_point(points[0], enemy1)
			__add_enemy_to_point(points[1], enemy1)
			__add_enemy_to_point(points[2], enemy1)
			__add_enemy_to_point(points[3], enemy2)
			__add_enemy_to_point(points[4], enemy2)
			__add_enemy_to_point(points[5], enemy3)
			__add_enemy_to_point(points[6], enemy3)

func __add_enemy_to_point(point, script):
	var enemy = enemy0.instance()
	enemy.set_script(script)
	point.add_child(enemy)
	

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