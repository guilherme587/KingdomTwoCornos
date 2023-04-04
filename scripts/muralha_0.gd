extends StaticBody2D

var vida:float = 150
var gramas:Array = []

func _ready():
	pass


func _physics_process(delta):
	if vida <= 0:
		queue_free()
	else:
		if not gramas.empty():
			for grama in gramas:
				gramas.remove(gramas.find(grama))
				grama.queue_free()


func hitted(dano:float):
	vida -= dano


func _on_Area2D_area_entered(area):
	gramas.append(area)

