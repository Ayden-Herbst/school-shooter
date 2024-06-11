extends Control

@export var audio: Node

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func _ready():
	audio.play()
