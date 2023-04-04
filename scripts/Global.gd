extends Node

var hora:float = 4
var minut:float = 0
var day:float = 3

func _ready():
	pass


func _physics_process(delta):
	minut += 6.1
	if minut >= 59:
		minut = 0
		hora += 1
		if hora >= 24:
			hora = 0
			day += 1
