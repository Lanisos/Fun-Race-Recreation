extends Area

func _ready():
	$MeshInstance.visible = false


func _on_RoofCollision_body_entered(body):
	body.death()
