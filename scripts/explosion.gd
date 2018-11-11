extends Sprite

func _ready():
	#yield(utils.create_timer(1), "timeout")
	
	randomize()
	rotation = deg2rad(rand_range(0, 360))
	
	$p_smoke.emitting = true
	$p_flare.emitting = true
	
	utils.remote_call("camera", "shake", 8, 0.2)
	
	$anim.play("fade_out")
	audio_player.play("explosion")
	yield($anim, "animation_finished")
	queue_free()
