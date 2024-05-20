extends Spatial

func _ready():
	$Timer.start()
	$Particles.emitting = true


func _on_Timer_timeout():
	$Area.set_collision_layer_bit(0, false)
	$Area.set_collision_mask_bit(0, false)


func _on_Area_body_entered(body):
	body.death()
