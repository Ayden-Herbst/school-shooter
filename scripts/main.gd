extends Node2D
var en = null

@export var player_spawn_point: Node
@export var laser_container: Node
@export var enemy_scenes: Array[PackedScene] = []
@export var background: Node

@export var timer: Node
@export var enemy_container: Node
@export var player: Node

var s = 150

func _ready():
	assert(player!=null)
	player.global_position = player_spawn_point.global_position

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	background.scroll_offset.y += delta * s

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	print(location)
	laser_container.add_child(laser)

func _on_enemy_spawn_timer_timeout():
	var sting_op = randi_range(1, 7)
	print(sting_op)
	if sting_op > 1:
		en = enemy_scenes[0].instantiate()
		en.global_position = Vector2(randf_range(50, 750), -10)	
		enemy_container.add_child(en)
	elif sting_op == 1:
		en = enemy_scenes[1].instantiate()
		en.global_position = Vector2(randf_range(50, 750), -10)	
		enemy_container.add_child(en)
