class_name Player extends CharacterBody2D

@export var speed:int = 750
@export var hp:float = 100.0
@export var ammo:int = 5

signal laser_shot(laser_scene, location)
signal health_changed(new_hp)
signal ammo_changed(new_ammo)

@export var muzzle: Node
var laser_scene = preload("res://scenes/laser.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
func _physics_process(_delta):
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
	
func change_health(amount:float, sign:bool):
	if sign == true:
		hp += amount
		hp = clamp(hp, 0, 100)
		health_changed.emit(hp)
		print("Health increased")
	elif sign == false:
		hp -= amount
		hp = clamp(hp, 0, 100)
		health_changed.emit(hp)
		print("Health Decreased")
		
func reload(amount:int):
	if ammo < 9:
		ammo += amount
		emit_signal("ammo_changed", ammo)
	print(ammo)

func die():
	queue_free()
	
