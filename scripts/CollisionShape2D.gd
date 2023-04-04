extends KinematicBody2D

var vida:float = 5
var x:float = 0
var y:float = 0
var vel:float = 10000
var jump_force:float = -300
var gravidade:float = 9.8
var recursos:Dictionary = {"madeira":0, "pedra":0, "moedas":0, "ferro":0, "alimento":0}
var dano:float = .5
var podeAtacar:bool = true

onready var ray = $RayCast2D
onready var ray1 = $RayCast2D2 
onready var sprite = $AnimatedSprite

var flecha = preload("res://prefabs/flecha.tscn")

func _ready():
	pass

func _physics_process(delta):
	if vida >= 0:
		move(delta)
		anim(x)
		arco()
	else:
		get_tree().reload_current_scene()


func arco():
	$arco.global_position = $Position2D.global_position
	if Input.is_action_just_released("ui_E"):
		$arco.visible = !$arco.visible
	$arco.look_at(get_global_mouse_position())
	if $arco.visible and Input.is_action_just_released("click_direito") and podeAtacar:
		podeAtacar = false
		var flechaInst = flecha.instance()
		flechaInst.hit(dano, Vector2( cos($arco.global_rotation), sin($arco.global_rotation) ).normalized(), $arco.forca )
		flechaInst.global_position = $arco.global_position
		get_parent().add_child(flechaInst)
		$Timer.start()


func anim(_x:float) -> void:
	if _x != 0:
		sprite.flip_h = false if _x > 0 else true
		$Position2D.position.x = 15 if _x > 0 else -15

func move(delta:float) -> void:
	x = float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left"))
	if ray.is_colliding() or ray1.is_colliding():
		if Input.is_action_just_pressed("ui_space"):
			y = 0
			y += jump_force 
		else:
			gravidade
	else:
		y += gravidade
	
	move_and_slide(Vector2(x * delta * vel, y))


func hitted(dano):
	vida -= dano


func _on_Timer_timeout():
	podeAtacar = true
