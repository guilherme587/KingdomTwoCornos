extends RigidBody2D

export var dano:float = 1
var dir:Vector2 = Vector2(0, -1)
var vel:float = 150


func _ready():
	pass

func _physics_process(delta):
	rotation = linear_velocity.normalized().angle()
	


func hit(_dano, _dir, _vel):
	dano = _dano
	dir = _dir
	vel = _vel
	self.apply_central_impulse(dir * vel)


func _on_Area2D_body_entered(body):
	if body.is_in_group("hitted"):
		body.hitted(dano)
		self.queue_free()
