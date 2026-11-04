extends Area2D

func _process(x):
	position.x -=get_parent().speed /2
	
func _on_area_entered(area):
		queue_free()
