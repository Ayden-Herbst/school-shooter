extends CanvasLayer

@export var health_bar: Node
@export var ammo_lable: Node

func _on_player_ammo_changed(new_ammo):
	ammo_lable.text = str(new_ammo)

func _on_player_health_changed(new_hp):
	health_bar.value = new_hp
	if new_hp >= 80:
		health_bar.get("theme_override_styles/fill").bg_color = Color.BLUE_VIOLET
	elif new_hp >= 70:
		health_bar.get("theme_override_styles/fill").bg_color = Color.CHOCOLATE
	elif new_hp >= 60:
		health_bar.get("theme_override_styles/fill").bg_color = Color.FIREBRICK
	elif new_hp >= 50:
		health_bar.get("theme_override_styles/fill").bg_color = Color.RED
	else:
		health_bar.get("theme_override_styles/fill").bg_color = Color.DARK_RED
		
		
		
		
		
		
	
	

