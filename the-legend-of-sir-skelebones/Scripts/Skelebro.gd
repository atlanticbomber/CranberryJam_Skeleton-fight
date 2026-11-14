extends CharacterBody2D

const SPEED = 350.0

func _physics_process(_delta: float) -> void:
	var Hdirection := Input.get_axis("left", "right")
	var Vdirection := Input.get_axis("up", "down")
	if Hdirection or Vdirection:
		velocity.x = Hdirection * SPEED
		velocity.y = Vdirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	Stats.PlayerLocation = position
	move_and_slide()

func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		Stats.PlayerHP -= 1
		Stats.Demeter -= 1
