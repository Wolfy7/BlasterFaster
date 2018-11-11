extends Sprite

export var velocity = Vector2()

func _ready():
	pass
	
	
func _process(delta):
	translate(velocity * delta)
	
	if position.y >= get_viewport_rect().size.y:
		position.y = -180
