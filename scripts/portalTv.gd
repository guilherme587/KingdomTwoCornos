extends Area2D

var inimigos:Array = [
	preload("res://prefabs/inimigo_0.tscn")
]

var itensPegos:Array = []


func _ready():
	pass


func _physics_process(delta):
	if Global.minut <= .1 and Global.hora == 19:
		for i in range(Global.day):
			var inimigoInst = inimigos[0].instance()
			inimigoInst.global_position = $Position2D.global_position
			get_parent().add_child(inimigoInst)


func _on_portalTv_body_entered(body):
	if body.is_in_group("inimigos") and body.pegouItem:
		itensPegos.append(body.item)
		body.queue_free()
