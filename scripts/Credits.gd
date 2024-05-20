extends Control

func _ready():
	$AudioStreamPlayer3.play()

func _on_Button_pressed():
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer,"finished")
	$AudioStreamPlayer3.stop()
	get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_Button_mouse_entered():
	$AudioStreamPlayer2.play()
