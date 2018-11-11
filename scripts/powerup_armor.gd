extends "res://scripts/powerup.gd"

func _ready():
	pass


func _on_area_enter( other ):
	if other.is_in_group("ship"):
		audio_player.play("powerup")
		other.armor += 1
		queue_free()
