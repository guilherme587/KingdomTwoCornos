extends Area2D


func _ready():
	$Timer.start(60)


func _on_Timer_timeout():
	self.queue_free()
