extends Position2D

func _physics_process(delta):
	self.rotation_degrees = -(360 / (Global.hora*60)+1) /2
