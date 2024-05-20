extends Spatial

var Bullet = preload("res://prefabs/Bullet.tscn")

func _ready():
	$AudioStreamPlayer3D.play()
	shoot_projectile()

func _on_Timer_timeout():
	$AudioStreamPlayer3D.play()
	shoot_projectile()

func shoot_projectile():
	var bullet = Bullet.instance()
	add_child(bullet)
	bullet.translate(Vector3(-0.2, 3.4, 0.0))
