extends Spatial

enum STATE {MOVING,STOPPED}

enum DIRECTION {X_POS,X_NEG,Z_POS,Z_NEG}

export (DIRECTION) var dir_chosen

export var distance = 1

export var velocity = 1.5

var ini_time = 0
var fin_time = 0

var curr_state = STATE.MOVING

var tot_trans = 0

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
			match dir_chosen:
				DIRECTION.X_POS:
					tot_trans += abs(velocity*delta)
					translate(Vector3(velocity*delta,0,0))
					if (tot_trans >= distance):
						$AudioStreamPlayer3D.stop()
						curr_state = STATE.STOPPED
						ini_time = OS.get_ticks_msec()
						fin_time = ini_time
						tot_trans = 0
						dir_chosen = DIRECTION.X_NEG
				DIRECTION.X_NEG:
					tot_trans += abs(-velocity*delta)
					translate(Vector3(-velocity*delta,0,0))
					if (tot_trans >= distance):
						$AudioStreamPlayer3D.stop()
						curr_state = STATE.STOPPED
						ini_time = OS.get_ticks_msec()
						fin_time = ini_time
						tot_trans = 0
						dir_chosen = DIRECTION.X_POS
				DIRECTION.Z_POS:
					tot_trans += abs(velocity*delta)
					translate(Vector3(0,0,velocity*delta))
					if (tot_trans >= distance):
						$AudioStreamPlayer3D.stop()
						curr_state = STATE.STOPPED
						ini_time = OS.get_ticks_msec()
						fin_time = ini_time
						tot_trans = 0
						dir_chosen = DIRECTION.Z_NEG
				DIRECTION.Z_NEG:
					tot_trans += abs(-velocity*delta)
					translate(Vector3(0,0,-velocity*delta))
					if (tot_trans >= distance):
						$AudioStreamPlayer3D.stop()
						curr_state = STATE.STOPPED
						ini_time = OS.get_ticks_msec()
						fin_time = ini_time
						tot_trans = 0
						dir_chosen = DIRECTION.Z_POS


func _on_Area_body_entered(body):
	body.death()
