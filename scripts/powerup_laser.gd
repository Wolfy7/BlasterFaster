extends "res://scripts/powerup.gd"

func _ready():
	pass


func _on_area_enter( other ):
	if other.is_in_group("ship"):
		other.is_double_shooting = true
		queue_free()
