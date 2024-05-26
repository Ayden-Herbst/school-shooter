extends CanvasLayer

# getting the respective nodes
@export var player_path : NodePath
@onready var health_bar = $ProgressBar
@onready var ammo_lable = $ammoLabel

# if you notice, I use a lot of very varied methods to get nodes please do fix that
func _ready():
	var player = get_node("../Player")
	# here where accessing the signals we set up earlier in the player script and using their values to update the UI elements
	if player:
		player.connect("health_changed", Callable(self, "_on_health_changed"))
		player.connect("ammo_changed", Callable(self, "_on_ammo_changed"))
		_on_health_changed(player.hp)
		_on_ammo_changed(player.ammo)
	

func _on_health_changed(new_hp):
	health_bar.value = new_hp

func _on_ammo_changed(new_ammo):
	ammo_lable.text = str(new_ammo)
