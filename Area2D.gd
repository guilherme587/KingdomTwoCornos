extends Area2D

var valor:float = 0
var tempVida:float = 0
export var amplitude:float = 20
export var frequencia:float = 1
var altura_inicial = Vector2.ZERO

func _ready():
	randomize()
	valor = int(rand_range(1, 2))
	tempVida = rand_range(300, 900)


func _physics_process(delta):
	if not $RayCast2D.is_colliding():
		self.global_position.y += 9.8


func _on_Area2D_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("vilage"):
		body.recursos["madeira"] += valor
		print('+',valor)
		self.queue_free()
