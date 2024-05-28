class_name Player extends CharacterBody2D

#defining speed, health and starting ammumition
@export var speed = 550.0
@export var hp = 100
@export var ammo = 5

# getting laser scene to be accessed
var laser_scene = preload("res://scenes/laser.tscn")

# so basically, we're just creating a signal here that will send the laser scene and the location where it should be spawned to the main.gd script
signal laser_shot(laser_scene, location)

# we're doing the same thing here for the health and the ammo, but were just sending their values to the HUD.gd script
signal health_changed(new_hp)
signal ammo_changed(new_ammo)

# and here we're just acting the muzzle which is just the pointed which we want the bullets to spawn relative to the player
@onready var muzzle = $Muzzle

# Again, this process function runs once every single frame, so we're checking if shoot was pressed, and if so, running the shoot function
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
		

func _physics_process(delta):
	# Getting the absolute direction in which the player wishes to move
	# Essentially creates a vector w/ 2 properties (x, x) to indicate direction
	var direction = Vector2(		
		Input.get_axis("move_left", "move_right"), # Horizontal Axis
		Input.get_axis("move_up", "move_down") # Vertical Axis
		)
	
	# velocity is already part of the move_and_slide() function. We are just assigning it
	velocity = direction * speed
	move_and_slide()
	
# sends a signal telling the game where the make the bullet appear from
func shoot():
	# we're controlling and altering the players ammunition here
	if ammo > 0:
		ammo -= 1
		laser_shot.emit(laser_scene, muzzle.global_position)
		# this signal will then be received by the hud and display the ammo
		emit_signal("ammo_changed", ammo)
	else: 
		print('out of ammo')
	
# handles our health reduction
func reduce_health(amount):
	hp -= amount
	hp = max(hp, 0)  # Ensure hp doesn't go below 0
	hp = min(hp, 100)
	emit_signal("health_changed", hp)
	if hp <= 0:
		die()

# handles our health regeneration, this could be consolidated into a single function, but I don't feel like doing that now
func increase_health(amount):
	hp += amount
	hp = max(hp, 0)  # Ensure hp doesn't go below 0
	hp = min(hp, 100)
	emit_signal("health_changed", hp)
	print(amount)

# This will just handle the increase in ammunition whenever an enemy is killed
func reload(amount):
	if ammo < 9:
		ammo += amount
		emit_signal("ammo_changed", ammo)
	print(ammo)


func die():
	# Handle the player's death here
	queue_free()
	
