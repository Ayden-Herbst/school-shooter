extends Node2D

var player = null
var en = null
# creating a variable that will receive its value on runtime (@onready)
# accesses and stores the spwan point node
@onready var player_spawn_point = $PlayerSpawnPoint
@onready var laser_container = $LaserContainer

@export var enemy_scenes: Array[PackedScene] = []
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	# Giving the game access to the player node 
	# (the node is stored in a  'group' called player)
	player = get_tree().get_first_node_in_group("player")
	#throws an error if player not found
	assert(player!=null)
	player.global_position = player_spawn_point.global_position
	
	player.laser_shot.connect(_on_player_laser_shot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func _on_player_laser_shot(laser_scene, location):
	# creating a laser instance
	var laser = laser_scene.instantiate()
	laser.global_position = location
	print(location)
	laser_container.add_child(laser)

func _on_enemy_spawn_timer_timeout():
	print('woof')
	var sting_op = randi_range(1, 10)
	print(sting_op)
	if sting_op > 1:
		en = enemy_scenes[0].instantiate()
		en.global_position = Vector2(randf_range(50, 750), -10)	
		enemy_container.add_child(en)
	elif sting_op == 1:
		en = enemy_scenes[1].instantiate()
		en.global_position = Vector2(randf_range(50, 750), -10)	
		enemy_container.add_child(en)
