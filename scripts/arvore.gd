extends StaticBody2D


var madeira = preload("res://prefabs/tronco.tscn")
var vida = 15


func hitted(dano):
	vida -= dano
	if vida <= 0:
		var madeiraInst = madeira.instance()
		madeiraInst.global_position = $Position2D.global_position
		get_parent().add_child(madeiraInst)
		$AnimationPlayer.play("morte")
		yield($AnimationPlayer, "animation_finished")
		self.queue_free()
