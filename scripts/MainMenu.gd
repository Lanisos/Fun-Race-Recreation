extends Control

func _ready():
	$AudioStreamPlayer3.play()

func _on_PlayButton_pressed():

	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer,"finished")
	$AudioStreamPlayer3.stop()
	get_tree().change_scene("res://scenes/Level01.tscn")


func _on_InstrButton_pressed():
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer,"finished")
	get_tree().change_scene("res://scenes/Instructions.tscn")

func _on_CreditsButton_pressed():
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer,"finished")
	get_tree().change_scene("res://scenes/Credits.tscn")

func _on_ExitButton_pressed():
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer,"finished")
	get_tree().quit()


func _on_PlayButton_mouse_entered():
	$AudioStreamPlayer2.play()


func _on_InstrButton_mouse_entered():
	$AudioStreamPlayer2.play()


func _on_CreditsButton_mouse_entered():
	$AudioStreamPlayer2.play()


func _on_ExitButton_mouse_entered():
	$AudioStreamPlayer2.play()
