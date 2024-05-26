extends CanvasLayer

@export var player_path : NodePath
@onready var health_bar = $ProgressBar
@onready var ammo_lable = $ammoLabel

func _process(_delta):
	var player = get_node("../Player")
	if player:
		player.connect("health_changed", Callable(self, "_on_health_changed"))
		player.connect("ammo_changed", Callable(self, "_on_ammo_changed"))
		_on_health_changed(player.hp)
		_on_ammo_changed(player.ammo)
	

func _on_health_changed(new_hp):
	health_bar.value = new_hp

func _on_ammo_changed(new_ammo):
	ammo_lable.text = str(new_ammo)
