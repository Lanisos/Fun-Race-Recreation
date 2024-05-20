extends Spatial

enum WINDMILL_TYPE {CONSTANT,SUDDEN}

enum DIRECTION {CLOCKWISE,ANTICLOCKWISE}

enum FACE_DIRECTION {Xs,Zs}

enum STATE {STOPPED,MOVING}

export (WINDMILL_TYPE) var wind_type
export (DIRECTION) var direction
export (FACE_DIRECTION) var face_dir

var ini_time = 0
var fin_time = 0

var curr_state = STATE.MOVING

var total_degrees = 0

func _physics_process(delta):
	match wind_type:
		WINDMILL_TYPE.CONSTANT:
			match direction:
				DIRECTION.CLOCKWISE:
					#rotate 0.5 degrees in y axis for each frame, more or less
					var rotation = 0.167 * PI * delta
					match face_dir:
						FACE_DIRECTION.Xs:
							rotate_x(-rotation)
						FACE_DIRECTION.Zs:
							rotate_z(-rotation)
				DIRECTION.ANTICLOCKWISE:
					#rotate -0.5 degrees in y axis for each frame, more or less
					var rotation = 0.167 * PI * delta
					match face_dir:
						FACE_DIRECTION.Xs:
							rotate_x(rotation)
						FACE_DIRECTION.Zs:
							rotate_z(rotation)
		WINDMILL_TYPE.SUDDEN:
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
					match direction:
						DIRECTION.CLOCKWISE:
							#rotate 1 degrees in y axis for each frame, more or less, until 90 are reached
							var rotation = 0.25 * PI * delta
							match face_dir:
								FACE_DIRECTION.Xs:
									rotate_x(-rotation)
								FACE_DIRECTION.Zs:
									rotate_z(-rotation)
							total_degrees += rotation
							if (total_degrees >= PI/2):
								$AudioStreamPlayer3D.stop()
								curr_state = STATE.STOPPED
								ini_time = OS.get_ticks_msec()
								fin_time = ini_time
								total_degrees = 0
						DIRECTION.ANTICLOCKWISE:
							#rotate 1 degrees in y axis for each frame, more or less, until 90 are reached
							var rotation = 0.25 * PI * delta
							match face_dir:
								FACE_DIRECTION.Xs:
									rotate_x(rotation)
								FACE_DIRECTION.Zs:
									rotate_z(rotation)
							total_degrees += rotation
							if (total_degrees >= PI/2):
								$AudioStreamPlayer3D.stop()
								curr_state = STATE.STOPPED
								ini_time = OS.get_ticks_msec()
								fin_time = ini_time
								total_degrees = 0


func _on_Area_body_entered(body):
	body.death()
