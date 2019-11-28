extends Node

const left = Vector2(-1, 0)
const right = Vector2(1, 0)

func rand():
	var dir = randi() % 2 + 1
	if (dir) == 1:
		return left
	elif dir == 2:
		return right

