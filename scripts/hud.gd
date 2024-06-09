extends CanvasLayer

# getting the respective nodes
@export var health_bar: Node
@export var ammo_lable: Node

func _on_player_ammo_changed(new_ammo):
	ammo_lable.text = str(new_ammo)

func _on_player_health_changed(new_hp):
	health_bar.value = new_hp
