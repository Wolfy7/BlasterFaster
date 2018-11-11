extends "res://scripts/enemy.gd"

const scn_laser = preload("res://scenes/laser_enemy.tscn")

func _ready():
	velocity.x = utils.choose([velocity.x, -velocity.x])
	
	yield(utils.create_timer(1), "timeout")
	shoot()

func _process(delta):
	if position.x <= 0+16:
		velocity.x = abs(velocity.x)
	if position.x >= utils.view_size.x-16:
		velocity.x = -abs(velocity.x)
		
func shoot():
	while true:
		var laser = scn_laser.instance()
		laser.position = $cannon.global_position
		utils.main_node.add_child(laser)
		audio_player.play("laser_enemy")
		yield(utils.create_timer(1.5), "timeout")