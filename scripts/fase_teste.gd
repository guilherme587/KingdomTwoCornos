extends Node2D

export var grama:PackedScene
var cells:Array = []
var gramasQuanti:float = 0

onready var tile = $TileMap


func _ready():
	randomize()
	$Timer.start()
	for cell in tile.get_used_cells():
		cells.append(cell)
	gramasQuanti = cells[-1][0] * 32


func _physics_process(delta):
	pass


func _on_Timer_timeout():
	if get_tree().get_nodes_in_group("gramas").size() <= gramasQuanti:
		var gramaInst:Object = grama.instance()
		var pos = Vector2(rand_range(cells[0][0] * 32, cells[-1][0] * 32) + 112, (cells[0][1] * 32) + 40)
		gramaInst.scale.x = rand_range(1, 2)
		self.add_child(gramaInst)
		gramaInst.global_position = pos
		$Timer.start()
	else:
		$Timer.start(300)
