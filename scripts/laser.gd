class_name Laser extends Area2D

@export var speed = 800


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.y += -speed * delta

# listens for the visibleonscreennotifier's exited signal and removes it from rendering
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Enemy || ProjectEnemy:
		queue_free()
		area.die()
