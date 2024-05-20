extends Spatial

enum STATE {MOVING,STOPPED}

enum DIRECTION {X_POS,X_NEG,Z_POS,Z_NEG}

enum TYPE {CLOSING,DISTANCE}

export (DIRECTION) var dir_chosen

export (TYPE) var prism_type

export var distance = 1

export var velocity = 1.5

export var delay = 0

var counter_trans = 0

var ini_time = 0
var fin_time = 0

var curr_state = STATE.MOVING

var tot_trans = 0

var counter_dir = false

var active_delay = false

func _ready():
	if (delay > 0):
		active_delay = true

func _physics_process(delta):
	match curr_state:
		STATE.STOPPED:
			fin_time = OS.get_ticks_msec()
			var elapsed = fin_time - ini_time
			if (elapsed >= 1500): 
				$AudioStreamPlayer3D.play()
				curr_state = STATE.MOVING
				fin_time = 0
				ini_time = 0
		STATE.MOVING:
			if (active_delay):
				fin_time = OS.get_ticks_msec()
				var elapsed = (delay*1000) - fin_time
				if (elapsed <= 0): 
					$AudioStreamPlayer3D.play()
					fin_time = 0
					active_delay = false
			else:
				match dir_chosen:
					DIRECTION.X_POS:
						tot_trans += abs(velocity*delta)
						translate(Vector3(velocity*delta,0,0))
						if (tot_trans >= distance and prism_type == TYPE.DISTANCE or (counter_dir and tot_trans >= counter_trans)):
							curr_state = STATE.STOPPED
							$AudioStreamPlayer3D.stop()
							ini_time = OS.get_ticks_msec()
							fin_time = ini_time
							tot_trans = 0
							dir_chosen = DIRECTION.X_NEG
							if (counter_dir): counter_dir = false
					DIRECTION.X_NEG:
						tot_trans += abs(-velocity*delta)
						translate(Vector3(-velocity*delta,0,0))
						if (tot_trans >= distance and prism_type == TYPE.DISTANCE or (counter_dir and tot_trans >= counter_trans)):
							curr_state = STATE.STOPPED
							$AudioStreamPlayer3D.stop()
							ini_time = OS.get_ticks_msec()
							fin_time = ini_time
							tot_trans = 0
							dir_chosen = DIRECTION.X_POS
							if (counter_dir): counter_dir = false
					DIRECTION.Z_POS:
						tot_trans += abs(velocity*delta)
						translate(Vector3(0,0,velocity*delta))
						if (tot_trans >= distance and prism_type == TYPE.DISTANCE or (counter_dir and tot_trans >= counter_trans)):
							curr_state = STATE.STOPPED
							$AudioStreamPlayer3D.stop()
							ini_time = OS.get_ticks_msec()
							fin_time = ini_time
							tot_trans = 0
							dir_chosen = DIRECTION.Z_NEG
							if (counter_dir): counter_dir = false
					DIRECTION.Z_NEG:
						tot_trans += abs(-velocity*delta)
						translate(Vector3(0,0,-velocity*delta))
						if (tot_trans >= distance and prism_type == TYPE.DISTANCE or (counter_dir and tot_trans >= counter_trans)):
							curr_state = STATE.STOPPED
							$AudioStreamPlayer3D.stop()
							ini_time = OS.get_ticks_msec()
							fin_time = ini_time
							tot_trans = 0
							dir_chosen = DIRECTION.Z_POS
							if (counter_dir): counter_dir = false


func _on_Area_area_entered(_area):
	$AudioStreamPlayer3D.stop()
	curr_state = STATE.STOPPED
	ini_time = OS.get_ticks_msec()
	fin_time = ini_time
	counter_trans = tot_trans
	tot_trans = 0
	counter_dir = true
	match dir_chosen:
		DIRECTION.X_POS:
			dir_chosen = DIRECTION.X_NEG
		DIRECTION.X_NEG:
			dir_chosen = DIRECTION.X_POS
		DIRECTION.Z_POS:
			dir_chosen = DIRECTION.Z_NEG
		DIRECTION.Z_NEG:
			dir_chosen = DIRECTION.Z_POS
			



func _on_Area_body_entered(body):
	body.death()
