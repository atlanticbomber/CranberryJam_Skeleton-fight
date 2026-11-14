extends CharacterBody2D

const SPEED = 350.0

var rollBonus: float = 1
var rollConst: float = 3.0
var rollWaitTimer: float = 2.0
@onready var rollTimer: Timer = $RollCooldown

@onready var weaponRange: Area2D = $WeaponRange
@onready var weaponShape: CollisionShape2D = $WeaponRange/CollisionShape2D
@onready var weaponTimer: Timer = $WeaponCooldown
var weaponDelay: float = 0.2
var weaponCooldown: float  = 1.0

func _ready() -> void:
	var newShape = CapsuleShape2D.new()
	newShape.height = 350
	newShape.radius = 175 #at most height/2
	weaponShape.shape = newShape
	weaponShape.position.x = newShape.height/2

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
		for body in weaponRange.get_overlapping_bodies():
			if body.has_method("EnemyDamage"):
				weaponTimer.start(weaponDelay)
				var tempDmg = 10.0
				body.EnemyDamage(tempDmg)
				weaponTimer.start(weaponCooldown)
