class_name Player extends CharacterBody2D

@export var speed:int = 550
@export var hp:int = 100
@export var ammo:int = 5

signal laser_shot(laser_scene, location)
signal health_changed(new_hp)
signal ammo_changed(new_ammo)

@export var muzzle: Node
var laser_scene = preload("res://scenes/laser.tscn")

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
func _physics_process(delta):
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"), # Horizontal Axis
		Input.get_axis("move_up", "move_down") # Vertical Axis
		)
		
	velocity = direction * speed
	move_and_slide()

func shoot():
	if ammo > 0:
		ammo -= 1
		laser_shot.emit(laser_scene, muzzle.global_position)
		emit_signal("ammo_changed", ammo)
	else: 
		print('out of ammo')
	

func reduce_health(amount:float):
	hp -= amount
	hp = max(hp, 0)  # Ensure hp doesn't go below 0
	hp = min(hp, 100)
	emit_signal("health_changed", hp)
	if hp <= 0:
		die()

func increase_health(amount:float):
	hp += amount
	hp = max(hp, 0) 
	hp = min(hp, 100)
	emit_signal("health_changed", hp)
	print(amount)

func reload(amount:int):
	if ammo < 9:
		ammo += amount
		emit_signal("ammo_changed", ammo)
	print(ammo)

func die():
	queue_free()
	
