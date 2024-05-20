extends Spatial

var Bomb = preload("res://prefabs/Bomb.tscn")

func _ready():
	var bomb = Bomb.instance()
	add_child(bomb)
		
func _on_Timer_timeout():
	var bomb = Bomb.instance()
	add_child(bomb)
