extends CharacterBody2D

const SPEED = 350.0
var rollBonus: float = 1
var rollConst: float = 3.0
var rollWaitTimer: float = 2.0
@onready var rollTimer: Timer = $RollCooldown

func _physics_process(_delta: float) -> void:
	#Rolling stuff
	if rollBonus==1 and rollTimer.is_stopped() and Input.is_action_just_pressed("roll"):
		rollBonus = rollConst
		rollTimer.start(rollWaitTimer)
	elif rollBonus > 1:
		rollBonus -= 0.1
	else:
		rollBonus = 1
	
	#Actual moving and stuff
	var Hdirection := Input.get_axis("left", "right")
	var Vdirection := Input.get_axis("up", "down")
	if Hdirection or Vdirection:
		velocity.x = Hdirection * SPEED * rollBonus
		velocity.y = Vdirection * SPEED * rollBonus
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	Stats.PlayerLocation = position
	move_and_slide()

#func _unhandled_key_input(_event: InputEvent) -> void:
#	if Input.is_action_just_pressed("ui_accept"):
#		Stats.PlayerHP -= 1
	#	Stats.Demeter -= 1
