class_name Enemy extends Area2D

@export var speed = 400.0
const hp_init = 1
@export var hp = 1
@onready var player = get_tree().get_first_node_in_group("player")

@export var test_enemy: Node
@export var explosion: Node
@export var exp_anim: Node

func _physics_process(delta):
	global_position.y += speed * delta

func die():
	test_enemy.visible = false
	explosion.visible = true
	exp_anim.play("new_animation")
	player.change_health(1, true)
	
	var amt = randi_range(1, 10)
	if amt <= 2:
		player.reload(3)
	elif amt <= 6:
		player.reload(2)
	else:
		player.reload(1)

	await get_tree().create_timer(1).timeout
	queue_free()
	
func lose_hp():
	hp -= 1
	hp = clamp(hp, 0, hp_init)
	if hp == 0:
		die()

func _on_visible_on_screen_notifier_2d_screen_exited():
	if player:
		player.change_health(10, false)
		print(player.hp)
		queue_free()
