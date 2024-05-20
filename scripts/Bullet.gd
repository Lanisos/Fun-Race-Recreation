extends Area

export(float) var MAX_VELOCITY = 0.18
export(float) var ACCELERATION = 0.005

var velocity = 0

func _physics_process(delta):
	velocity = velocity + ACCELERATION
	velocity = min(velocity, MAX_VELOCITY)
	
	translate(Vector3(-velocity, 0.0, 0.0))
	if get_translation().x < -25:
		queue_free()


func _on_VisibilityNotifier_screen_exited():
	queue_free()


func _on_Bullet_body_entered(body):
	body.death()
