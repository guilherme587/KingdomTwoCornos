extends KinematicBody2D


var x:float = 0
var y:float = 0
var vel:float = 15000
var jump_force:float = -300
var gravidade:float = 9.8
var inimigos:Array = []
var vida:float = 3

onready var ray = $RayCast2D
onready var ray1 = $RayCast2D2
onready var sprite = $AnimatedSprite
onready var visao = $Area2D

func _ready():
	pass

func _physics_process(delta):
	move(delta)
	anim(x)

func anim(_x:float) -> void:
	if _x != 0:
		sprite.flip_h = false if _x > 0 else true

func move(delta:float) -> void:
	if not inimigos.empty():
		var maisPerto = inimigos[0]
		for inimigo in inimigos:
			if abs(inimigo.position.x - self.position.x) < abs(maisPerto.position.x - self.position.x):
				maisPerto = inimigo
		x = .1 if (self.position.x - maisPerto.position.x) > 0 else -.1
	
	if ray.is_colliding() or ray1.is_colliding():
		y = 0
	else:
		y += gravidade
	
	move_and_slide(Vector2(x * delta * vel, y))


func _on_Area2D_body_entered(body):
	inimigos.append(body)


func _on_Area2D_body_exited(body):
	inimigos.remove( inimigos.find(body) )
	$Timer.start( rand_range(5, 15) )


func hitted(dano:float):
	vida -= dano
	if vida <= 0:
		self.queue_free()


func _on_Timer_timeout():
	x = 0
