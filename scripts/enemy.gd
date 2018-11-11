extends Area2D

export var velocity = Vector2()
export var armor = 2 setget set_armor

const scn_explosion = preload("res://scenes/explosion.tscn")

func _ready():
	add_to_group("enemy")

func _process(delta):
	translate(velocity * delta)
	
	if position.y-16 >= get_viewport_rect().size.y:
		queue_free()
		
func set_armor(new_value):
	if is_queued_for_deletion(): return
	armor = new_value
	audio_player.play("hit_enemy")
	if armor <= 0:
		utils.find_node("tex_score").score += 5
		create_explosion()
		queue_free()	

func _on_area_enter( other ):
	if other.is_in_group("ship"):
		other.armor -= 1
		create_explosion()
		queue_free()
		
func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.position = position
	utils.main_node.add_child(explosion)
