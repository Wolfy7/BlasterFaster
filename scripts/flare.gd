extends Sprite

func _ready():
	$anim.play("fade_out")
	yield($anim, "animation_finished")
	queue_free()
