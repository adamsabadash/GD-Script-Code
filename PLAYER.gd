extends KinematicBody2D

const Min_Speed = 100
const Max_Speed = 200
const Acceleration = 2000
var Motion = Vector2.ZERO
var Direction = Vector2.ZERO

func _physics_process(delta):
	var Axis = Get_Input_Axis()
	if Axis == Vector2.ZERO:
		Apply_Friction(Acceleration * delta)

	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if Direction == Vector2(0, -1):
			$Sprite.play("Thrust Forward")
			
		elif Direction == Vector2(0, 1):
			$Sprite.play("Thrust Backward")
			
		elif Direction == Vector2(-1, 0):
			$Sprite.play("Thrust Left")
			
		else:
			$Sprite.play("Thrust Right")
			
	elif Input.is_mouse_button_pressed(BUTTON_RIGHT):
		if Direction == Vector2(0, -1):
			$Sprite.play("Block Forward")
			
		elif Direction == Vector2(0, 1):
			$Sprite.play("Block Backward")
			
		elif Direction == Vector2(-1, 0):
			$Sprite.play("Block Left")
			
		elif Direction == Vector2(1, 0):
			$Sprite.play("Block Right")
		
	elif Input.is_key_pressed(KEY_SHIFT):
		pass
		Apply_Movement_Fast(Axis * Acceleration * delta) 
		
		if Motion.y < 0:
			Direction = Vector2(0, -1)
			$Sprite.play("Run Forward")
			
		elif Motion.y > 0:
			Direction = Vector2(0, 1)
			$Sprite.play("Run Backward")
			
		elif Motion.x < 0:
			Direction = Vector2(-1, 0)
			$Sprite.play("Run Left")
			
		elif Motion.x > 0:
			Direction = Vector2(1, 0)
			$Sprite.play("Run Right")
			
		else:
			Motion = Vector2.ZERO
		
			if Direction == Vector2(0, -1):
				$Sprite.play("Idle Forward")
			
			elif Direction == Vector2(1, 0):
				$Sprite.play("Idle Right")
			
			elif Direction == Vector2(-1, 0):
				$Sprite.play("Idle Left")
			
			else:
				$Sprite.play("Idle")
				
	else:
		Apply_Movement_Slow(Axis * Acceleration * delta)
		
		if Motion.y < 0:
			Direction = Vector2(0, -1)
			$Sprite.play("Walk Forward")
			
		elif Motion.y > 0:
			Direction = Vector2(0, 1)
			$Sprite.play("Walk Backward")
			
		elif Motion.x < 0:
			Direction = Vector2(-1, 0)
			$Sprite.play("Walk Left")
			
		elif Motion.x > 0:
			Direction = Vector2(1, 0)
			$Sprite.play("Walk Right")
			
		else:
			Motion = Vector2.ZERO
		
			if Direction == Vector2(0, -1):
				$Sprite.play("Idle Forward")
			
			elif Direction == Vector2(1, 0):
				$Sprite.play("Idle Right")
			
			elif Direction == Vector2(-1, 0):
				$Sprite.play("Idle Left")
			
			else:
				$Sprite.play("Idle")
				
	Motion = move_and_slide(Motion)

func Get_Input_Axis():
	var Axis = Vector2.ZERO
	var Axis_2 = Vector2.ZERO
	Axis.x = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A))
	Axis.y = int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))
	Axis_2.x = int(Input.is_key_pressed(KEY_RIGHT)) - int(Input.is_key_pressed(KEY_LEFT))
	Axis_2.y = int(Input.is_key_pressed(KEY_DOWN)) - int(Input.is_key_pressed(KEY_UP))
	
	if Axis:
		return Axis.normalized()
		
	else:
		return Axis_2.normalized()
	
func Apply_Friction(Amount):
	if Motion.length() > Amount:
		Motion -= Motion.normalized() * Amount
		
	else:
		Motion = Vector2.ZERO
	
func Apply_Movement_Slow(acceleration):
	Motion += acceleration
	Motion = Motion.clamped(Min_Speed)
	
func Apply_Movement_Fast(acceleration):
	Motion += acceleration
	Motion = Motion.clamped(Max_Speed)