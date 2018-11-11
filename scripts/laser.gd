extends Area2D

export var velocity = Vector2()
const scn_flare = preload("res://scenes/flare.tscn")

func _ready():
	create_flare()
	
	yield($vis_notifier, "screen_exited")
	queue_free()
	pass

func _process(delta):
	translate(velocity * delta)
	
func create_flare():
	var flare = scn_flare.instance()
	flare.position = position
	utils.main_node.add_child(flare)
	