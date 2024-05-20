extends Spatial

const MAX_VELOCITY = 0.18
const ACCELERATION = 0.005

const ExplEffect = preload("res://prefabs/ExplEffect.tscn")

var timer1_act = false
var timer2_act = false

var velocity = 0

func _ready():
	$Timer1.start()
	timer1_act = true
	
func explosion():
	var explEffect = ExplEffect.instance()
	$AudioStreamPlayer3D.play()
	add_child(explEffect)
	$MeshInstance.visible = false
	$Area.set_collision_layer_bit(0, false)
	$Area.set_collision_mask_bit(0, false)

func _physics_process(delta):
	if (timer1_act):
		velocity = velocity + ACCELERATION
		velocity = min(velocity, MAX_VELOCITY)
		
		translate(Vector3(0,-velocity,0))
		

func _on_Area_body_entered(body):
	body.death()

func _on_Timer1_timeout():
	explosion()
	$Timer2.start()
	timer1_act = false


func _on_Timer2_timeout():
	queue_free()
