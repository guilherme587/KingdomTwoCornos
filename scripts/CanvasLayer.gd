extends CanvasLayer

onready var label0 = $Label2
onready var label1 = $Label

func _physics_process(delta):
	textUpdate()
	aling()


func textUpdate():
	$Label.text = str("DAY: ") + str(Global.day)
	$Label2.text = str(Global.hora) + ':' if Global.hora > 9 else '0' + str(Global.hora) + ':'
	$Label2.text += str(int(Global.minut)) if Global.minut > 9 else '0' + str(int(Global.minut))


func aling():
	if label0.rect_position.x + label0.rect_size.x > 180:
		$Label2.rect_position = Vector2(label0.rect_position.x - label0.rect_size.x, label0.rect_position.y)
	if label1.rect_position.x + label1.rect_size.x > 180/2:
		$Label.rect_position = Vector2(180/2 - label1.rect_size.x/2, label0.rect_position.y)
