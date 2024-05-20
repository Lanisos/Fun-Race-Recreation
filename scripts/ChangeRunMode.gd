extends Area

export(int) var runMode = 0;

func _ready():
	$MeshInstance.visible = false

func _on_RespawnPoint_body_entered(body):
	body.changeRunMode(runMode)
