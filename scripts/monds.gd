extends Area2D

func _process(x):
	position.x -=get_parent().speed /2
	
func _on_area_entered(area: Area2D) -> void:
	if area.name == "loverboy":
		$main.score += 1
		queue_free()
