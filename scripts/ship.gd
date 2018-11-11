extends Area2D

var armor = 4 setget set_armor
var is_double_shooting = false setget set_double_shooting

const scn_laser = preload("res://scenes/laser_ship.tscn")
const scn_explosion = preload("res://scenes/explosion.tscn")
const scn_flash = preload("res://scenes/flash.tscn")

signal armor_changed

func _ready():
	add_to_group("ship")
	yield(utils.create_timer(0.5), "timeout")
	shoot()
	pass

func _process(delta):
	var motion = (get_global_mouse_position().x - position.x) * 0.2
	translate(Vector2(motion, 0))
	
	var view_size = get_viewport_rect().size
	position.x = clamp(position.x, 0+16, view_size.x-16)


func shoot():
	while true:
		create_laser($canons/left.global_position)
		create_laser($canons/right.global_position)
		
		if is_double_shooting:
			var laser_left = create_laser($canons/left.global_position)
			var laser_right = create_laser($canons/right.global_position)
			laser_left.velocity.x = -25
			laser_right.velocity.x = 25
		
		yield(utils.create_timer(0.25), "timeout")

func set_armor(new_value):
	if new_value > 4: return
	
	if new_value < armor:
		utils.main_node.add_child(scn_flash.instance())
		audio_player.play("hit_ship")
		
	armor = new_value
	emit_signal("armor_changed", armor)
	
	if armor <= 0:
		create_explosion()
		queue_free()
		
func set_double_shooting(new_value):
	is_double_shooting = new_value
	
	if is_double_shooting:
		yield(utils.create_timer(5), "timeout")
		is_double_shooting = false

func create_laser(pos):
	var laser = scn_laser.instance()
	laser.position = pos
	utils.main_node.add_child(laser)
	audio_player.play("laser_ship")
	return laser
	
func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.position = position
	utils.main_node.add_child(explosion)