extends Area

export(int) var cameraMode = 0;

func _ready():
	$MeshInstance.visible = false

func _on_ChangeRunMode_body_entered(body):
	body.changeCamera(cameraMode)
