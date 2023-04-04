extends RigidBody2D

var vida:float = 1
var dano:float = 1
var x:float = 0
var y:float = 0
var vel:float = 700
var gravidade:float = 9.8
var podeaAtacar:bool = true
var alvo:float = 0
var pegouItem:bool = false
var item:String = ""
var initPos:float = 0

onready var ray = $RayCast2D
onready var ray1 = $RayCast2D2
onready var rayAtack = $RayCast2D3
onready var sprite = $AnimatedSprite

func _ready():
	initPos = self.global_position.x


func _physics_process(delta):
	if not pegouItem:
		move(delta)
		anim(x)
		attack()
		alvo = get_parent().get_node("player").global_position.x
	else:
		move(delta)
		anim(x)
		alvo = initPos

func anim(_x:float) -> void:
	if _x != 0:
		sprite.flip_h = false if _x > 0 else true
		rayAtack.rotation_degrees = -90 if x > 0 else 90

func move(delta:float) -> void:
	if abs(alvo - self.global_position.x) >= 8:
		x = -.3 if alvo - self.global_position.x <= 0 else .3
	else:
		x = 0
	if ray.is_colliding() or ray1.is_colliding():
		y = 0
	else:
		y += gravidade
	if self.linear_velocity.x <= 100:
		apply_central_impulse(Vector2(x * delta * vel, y))
	self.rotation_degrees = 0


func attack():
	if rayAtack.is_colliding():
		if rayAtack.get_collider().has_method("hitted") and podeaAtacar:
			impulsoAtaque()
			rayAtack.get_collider().hitted(dano)
			podeaAtacar = false
			$Timer.start()
	else:
		x = 1


func impulsoAtaque():
	var xAttack:float = 0
	var yAttack:float = -300
	
	if alvo - self.global_position.x <= 0:
		x = -100
	else:
		x = 100
	self.apply_central_impulse(Vector2(xAttack, yAttack))


func _on_Timer_timeout():
	podeaAtacar = true
	
func hitted(dano):
	vida -= dano
	if vida <= 0:
		self.queue_free()
