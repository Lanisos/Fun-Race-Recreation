extends PathFollow

onready var animationPlayer = $Player/AnimationPlayer
onready var animationCamera = $AnimationCamera

export(float) var velocity = 0.0
export(bool) var left_player = true
export(int) var level = 1


var current_state = IDLE
var respawn_point = 0
var key_to_press = ""
var invincible_mode = false
var move_mode = 0;
var win = false
var sound_playing = false

enum {RUN, IDLE, DEATH, VICTORY, DEFEAT, CRAWL, CLIMB}

func _ready():
	win = false
	if left_player:
		key_to_press = "ui_run_left_player"
	else:
		key_to_press = "ui_run_right_player"

func _physics_process(delta):

	check_change_level()

	if Input.is_action_just_pressed("ui_invincible"):
		change_invicnible_mode()

	if current_state != DEATH and current_state != VICTORY:
		if Input.is_action_pressed(key_to_press):
			offset = offset + velocity
			if (move_mode == 0):
				current_state = RUN
			elif (move_mode == 1):
				current_state = CRAWL
			elif (move_mode == 2):
				current_state = CLIMB
			play_avance_anim()
		else:
			if move_mode <= 1:
				current_state = IDLE
				animationPlayer.play("Idle")
			elif move_mode == 2:
				current_state = IDLE
				animationPlayer.play("ClimbIdle")

	if unit_offset == 1:
		if (not sound_playing):
			$AudioStreamPlayer.play()
			sound_playing = true
		current_state = VICTORY
		animationPlayer.play("Victory")
		if (!win):
			win = true
			$ChangeLevel.start(5)


func reset_position_to_spawPoint():
	offset = respawn_point
	$Player.visible = true
	current_state = IDLE
	move_mode = 0
	animationCamera.play("ResetCamera")
	$Player.set_collision_layer_bit(0, true)
	$Player.set_collision_mask_bit(0, true)

func set_respawn_point():
	respawn_point = offset
	print("Respawn point set at: " + String(offset))

func set_death_state():
	current_state = DEATH

func crawl():
	move_mode = 1
	print("Crawl mode")


func run():
	move_mode = 0
	print("Run mode")

func climb():
	move_mode = 2
	print("Climb mode")

func sideCamera():
	animationCamera.play("SideCamera")

func backCamera():
	animationCamera.play("BackCamera")

func change_invicnible_mode():
	if invincible_mode:
		$Player.set_collision_layer_bit(0, true)
		$Player.set_collision_mask_bit(0, true)
		invincible_mode = false
	else:
		$Player.set_collision_layer_bit(0, false)
		$Player.set_collision_mask_bit(0, false)
		invincible_mode = true

func play_avance_anim():
	if current_state == RUN:
		animationPlayer.play("Run")
	elif current_state == CRAWL:
		animationPlayer.play("Crawl")
	elif current_state == CLIMB:
		animationPlayer.play("Climb")

func check_change_level():
	if Input.is_action_just_pressed("level01"):
		get_tree().change_scene("res://scenes/Level01.tscn")
	elif Input.is_action_just_pressed("level02"):
		get_tree().change_scene("res://scenes/Level02.tscn")
	elif Input.is_action_just_pressed("level03"):
		get_tree().change_scene("res://scenes/Level03.tscn")
	elif Input.is_action_just_pressed("level04"):
		get_tree().change_scene("res://scenes/Level04.tscn")
	elif Input.is_action_just_pressed("level05"):
		get_tree().change_scene("res://scenes/Level05.tscn")


func _on_ChangeLevel_timeout():
	$AudioStreamPlayer.stop()
	match level:
		1:
			get_tree().change_scene("res://scenes/Level02.tscn")
		2:
			get_tree().change_scene("res://scenes/Level03.tscn")
		3:
			get_tree().change_scene("res://scenes/Level04.tscn")
		4:
			get_tree().change_scene("res://scenes/Level05.tscn")
		5:
			get_tree().change_scene("res://scenes/Credits.tscn")
