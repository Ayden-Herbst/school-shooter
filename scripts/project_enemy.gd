class_name ProjectEnemy extends Area2D

@export var speed = 75.0

const hp_init = 4
@export var hp = 4
@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	global_position.y += speed * delta

func die():
	player.reload(5)
	queue_free()
	
func lose_hp():
	hp -= 1
	hp = clamp(hp, 0, hp_init)
	if hp == 0:
		die()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	if player:
		player.change_health(20, false)
		queue_free()
