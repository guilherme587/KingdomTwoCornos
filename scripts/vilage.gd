extends KinematicBody2D


var vida = 0
var x:float = 0
var y:float = 0
var vel:float = 10000
var gravidade:float = 9.8
var recursos:Dictionary = {"madeira":0, "pedra":0, "moedas":0, "ferro":0, "alimento":0}
var distAndar:float = 0

enum{
	MENDIGO, ARQUEIRO, PEDREIRO, GUERREIRO
}
var STATE = MENDIGO

onready var ray = $RayCast2D
onready var ray1 = $RayCast2D2
onready var sprite = $AnimatedSprite

func _ready():
	pass

func _physics_process(delta):
	move(delta)
	anim(x)
	match STATE:
		MENDIGO:
			print("mendigo")
		ARQUEIRO:
			print("arqueiro")
		PEDREIRO:
			print("pedreiro")
		GUERREIRO:
			print("guerreiro")


func anim(_x:float) -> void:
	if _x != 0:
		sprite.flip_h = false if _x > 0 else true

func move(delta:float) -> void:
	x = 1
	if ray.is_colliding() or ray1.is_colliding():
		y = 0
	else:
		y += gravidade


func hitted(dano):
	vida -= dano
	if vida <= 0:
		STATE = MENDIGO
