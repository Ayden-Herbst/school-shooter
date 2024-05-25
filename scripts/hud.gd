extends CanvasLayer

@export var player_path : NodePath
@onready var health_bar = $ProgressBar

func _ready():
	var player = get_node("../Player")
	if player:
		player.connect("health_changed", Callable(self, "_on_health_changed"))
		_on_health_changed(player.hp)

func _on_health_changed(new_hp):
	health_bar.value = new_hp
