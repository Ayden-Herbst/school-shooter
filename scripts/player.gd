class_name Player extends CharacterBody2D

#defining speed
@export var speed = 400.0
@export var hp = 100

#getting laser scene to be accessed
var laser_scene = preload("res://scenes/laser.tscn")
signal laser_shot(laser_scene, location)
signal health_changed(new_hp)

@onready var muzzle = $Muzzle

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
	
# sends a signal telling the game where the make the bullet appear from and what to make apear
func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position)
	
func reduce_health(amount):
	hp -= amount
	hp = max(hp, 0)  # Ensure hp doesn't go below 0
	emit_signal("health_changed", hp)
	if hp <= 0:
		die()
		
func die():
	# Handle the player's death here
	queue_free()
	
