extends KinematicBody

const DeathEffect = preload("res://prefabs/DeathEffect.tscn")

func death():
	get_parent().set_death_state()
	make_death_effect()
	$DeathTime.start(1.5)

func set_respawn_point():
	get_parent().set_respawn_point()

func _on_DeathTime_timeout():
	get_parent().reset_position_to_spawPoint()
	get_parent().get_child(4).stop()

func make_death_effect():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.scale = Vector3(0.6,0.6,0.6)
	deathEffect.translate(Vector3(0.0, 4.0, 0.0))
	visible = false
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(0, false)
	get_parent().get_child(4).play()

func changeRunMode(var mode):
	if mode == 0:
		get_parent().run()
	elif mode == 1:
		get_parent().crawl()
	elif mode == 2:
		get_parent().climb()
		
func changeCamera(var mode):
	if mode == 0:
		get_parent().sideCamera()
	elif mode == 1:
		get_parent().backCamera()

func victory():
	pass
