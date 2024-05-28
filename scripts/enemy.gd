class_name Enemy extends Area2D

# the test enemy's speed
@export var speed = 400.0
# the test. enemy's health (takes 1 shot to kill)
@export var hp = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# just enabling movement
	global_position.y += speed * delta

func die():
	# accesing the player to use its functions/variables
	var player_node = get_tree().get_first_node_in_group("player")

	# adding health to the player when enemy is killed by a shot
	player_node.increase_health(1)
	# giving the player 2 ammunition when enemy killed
	player_node.reload(1)

	# just for debugging
	print("enemy dies")
	# removing from scene
	queue_free()
	
func lose_hp():
	# yeah, donny. my code is damn innefficient. ik
	# i could just queue_free() here, bu want to allow for further expandability
	# i'm pretty sure you can figure out whats going on here
	hp -= 1
	hp = max(hp, 0)  # Ensure hp doesn't go below 0
	if hp == 0:
		die()
	
# ok... the enemy has a 'visible_on_screen_notifier' node inside of it. this emits signals when the frame is entered and exited
# we only need the exit one. i've 'linked' it to here using the inspector/signals panel.
# essentially, whenever the enemy exits the screen (leaves at the bottom) this happens

func _on_visible_on_screen_notifier_2d_screen_exited():
	
	# again, just accessing the player node. I could do it at the top, but it was throwing errors.
	# i relaise now that it needs to be both @onready and @export to fix the issue. 
	# you fix that.
	var player_node = get_tree().get_first_node_in_group("player") #ps: the player is assigned to a godot node 'group' which just allows me to access it
	
	# quite simple, if we do get a value for player_node (i.e. != null), we call its reduce_health function and remove the enemy															# can't do this to a class and don't bloody want to get_node()
	if player_node:
		player_node.reduce_health(10)
		print(player_node.hp)
		queue_free() # free the enemy node when it exits the screen
