class_name Player extends CharacterBody2D

@export var speed:int = 1250
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
		
func _physics_process(delta):
	var target_position = get_viewport().get_mouse_position()
	var distance = target_position.distance_to(self.position)

	# Define dead zone radius
	var dead_zone_radius = 10.0 

	if distance > dead_zone_radius:
		var movement_vector = target_position - self.position
		movement_vector = movement_vector.normalized() * delta * speed
		position = position.lerp(target_position, 0.7)

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
	
