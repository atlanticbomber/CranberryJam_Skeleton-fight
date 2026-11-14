extends CharacterBody2D

@export var currentWeapon:WeaponResource

const SPEED = 350.0

var rollBonus: float = 1
var rollConst: float = 3.0
var rollWaitTimer: float = 2.0
@onready var rollTimer: Timer = $RollCooldown

@onready var IFrames: Timer = $ICooldown
var IFramesWaitTime: float = 1.0

@onready var weaponRange: Area2D = $WeaponRange
@onready var weaponShape: CollisionShape2D = $WeaponRange/CollisionShape2D
@onready var weaponTimer: Timer = $WeaponCooldown

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
		velocity.x = Hdirection * SPEED * rollBonus
		velocity.y = Vdirection * SPEED * rollBonus
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	#Weapon sense
	weaponRange.look_at(get_global_mouse_position())
	#print(weaponRange.get_overlapping_bodies())
	
	Stats.PlayerLocation = position
	move_and_slide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack") and weaponTimer.is_stopped():
		print("frame",get_tree().get_frame())
		weaponTimer.start(currentWeapon.delay)
		await weaponTimer.timeout
		for body in weaponRange.get_overlapping_bodies():
			if body.has_method("EnemyDamage"):
				$Attack.play()
				print(Stats.currentActive)
				body.EnemyDamage(currentWeapon.damage)
		weaponTimer.start(currentWeapon.cooldown)

func takeDamage(damage:int):
	if IFrames.is_stopped():
		Stats.PlayerHP -= damage
		IFrames.start(IFramesWaitTime)
	
func weaponChange():
	#print(Stats.currentActive)
	await get_tree().create_timer(0.1).timeout
	currentWeapon = Stats.currentActive
	weaponShape.shape = currentWeapon.shape
	weaponShape.position.x = (currentWeapon.shape.height/2) - currentWeapon.towardsCenter
