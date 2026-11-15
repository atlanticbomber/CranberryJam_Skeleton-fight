class_name Player
extends CharacterBody2D

@export var currentWeapon:WeaponResource

var rollBonus: float = 1
var rollConst: float = 3.0
var rollWaitTimer: float = 2.0
@onready var rollTimer: Timer = $RollCooldown

@onready var IFrames: Timer = $ICooldown
var IFramesWaitTime: float = 1.0

@onready var weaponRange: Area2D = $WeaponRange
@onready var weaponShape: CollisionShape2D = $WeaponRange/CollisionShape2D
@onready var weaponTimer: Timer = $WeaponCooldown

signal game_over

func _ready() -> void:
	weaponChange()
	Stats.connect("weaponChange",weaponChange)

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
		velocity.x = Hdirection * Stats.PlayerSpeed * rollBonus
		velocity.y = Vdirection * Stats.PlayerSpeed * rollBonus
		$AnimationPlayer.play("Walk")
	else:
		$AnimationPlayer.play("Idle")
		velocity.x = move_toward(velocity.x, 0, Stats.PlayerSpeed)
		velocity.y = move_toward(velocity.y, 0, Stats.PlayerSpeed)
	
	
	#Weapon sense
	weaponRange.look_at(get_global_mouse_position())
	#print(weaponRange.get_overlapping_bodies())
	
	Stats.PlayerLocation = position
	move_and_slide()

func _process(_delta: float) -> void:
	if Input.is_action_pressed("zoom out") and $Camera2D.zoom >Vector2(0.9,0.9):
		$Camera2D.zoom -= Vector2(0.01,0.01)
	elif Input.is_action_pressed("zoom in") and $Camera2D.zoom <Vector2(1.4,1.4):
		$Camera2D.zoom += Vector2(0.01,0.01)
	
	#Eye Motion
	$Sprite/Skull/BigEye.position = Vector2(3.5,-0.5) + Vector2(3,1.5)*(get_global_mouse_position() - position).normalized()
	$Sprite/Skull/SmallEye.position = Vector2(22,-6.0) + Vector2(1.5,1.5)*(get_global_mouse_position() - position).normalized()
	
	
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack") and weaponTimer.is_stopped():
		print("frame",get_tree().get_frame())
		var weaponPlayer:AnimationPlayer = $Sprite/Body/ActiveUpperArm/AnimationPlayer
		weaponTimer.start(currentWeapon.delay)
		weaponPlayer.play("0",-1,0.2/currentWeapon.delay)
		await weaponTimer.timeout
		for body in weaponRange.get_overlapping_bodies():
			if body.has_method("EnemyDamage"):
				$Attack.play()
				print(Stats.currentActive)
				body.EnemyDamage(currentWeapon.damage*Stats.PlayerAttack)
		weaponTimer.start(currentWeapon.cooldown)
		weaponPlayer.play("return",-1,0.5/currentWeapon.cooldown)

func takeDamage(damage:int):
	if IFrames.is_stopped():
		Stats.PlayerHP -= damage
		IFrames.start(IFramesWaitTime)
	if Stats.PlayerHP <= 0:
		game_over.emit()
	
func weaponChange():
	#print(Stats.currentActive)
	await get_tree().create_timer(0.1).timeout
	currentWeapon = Stats.currentActive
	weaponShape.shape = currentWeapon.shape
	weaponShape.position.x = (currentWeapon.shape.height/2) - currentWeapon.towardsCenter
	$Sprite/Body/Fist.texture = currentWeapon.texture
	
	var newShape:PackedVector2Array = [Vector2(3,0),
	Vector2(currentWeapon.shape.height,-currentWeapon.shape.radius),
	Vector2(currentWeapon.shape.height,currentWeapon.shape.radius)]
	$WeaponRange/Polygon2D.polygon = newShape

	
