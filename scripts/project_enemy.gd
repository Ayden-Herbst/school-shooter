class_name ProjectEnemy extends Area2D

@export var speed = 100.0
@export var player : NodePath
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.y += speed * delta

func die():
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	var player_node = get_node("../Player") as CharacterBody2D #Accesses the Player Node
	if player_node:
		player_node.reduce_health(20)
		print(player_node.hp)
		queue_free() # free the enemy node when it exits the screen
