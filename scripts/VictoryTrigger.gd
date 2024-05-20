extends Area

func _ready():
	$MeshInstance.visible = false

func _on_RespawnPoint_body_entered(body):
	body.victory()
