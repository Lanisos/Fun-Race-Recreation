extends Spatial

func disappear():
	queue_free()

func _on_Area_body_entered(body):
	body.death()
