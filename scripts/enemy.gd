class_name Enemy extends Area2D

@export var speed = 400.0

const hp_init = 1
@export var hp = 1

func _physics_process(delta):
	global_position.y += speed * delta

func die():
	var player_node = get_tree().get_first_node_in_group("player")
	player_node.change_health(1, true)
	player_node.reload(1)
	queue_free()
	
func lose_hp():
	hp -= 1
	hp = clamp(hp, 0, hp_init)
	if hp == 0:
		die()

func _on_visible_on_screen_notifier_2d_screen_exited():
	var player_node = get_tree().get_first_node_in_group("player")
	if player_node:
		player_node.change_health(10, false)
		print(player_node.hp)
		queue_free()
