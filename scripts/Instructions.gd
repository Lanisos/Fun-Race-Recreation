extends Control

func _ready():
	$AudioStreamPlayer3.play()

func _on_BackButton_pressed():
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer,"finished")
	$AudioStreamPlayer3.stop()
	get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_BackButton_mouse_entered():
	$AudioStreamPlayer2.play()
