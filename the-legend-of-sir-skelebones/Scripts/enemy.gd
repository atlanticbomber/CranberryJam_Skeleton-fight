class_name Enemy
extends CharacterBody2D

@export var EN:EnemyResource = load("res://Resources/Enemy/BasicEnemy.tres")

var MaxEnemyHP: float = EN.maxHP
var EnemyHP: float = EN.maxHP

var SPEED = EN.speed

var playerSnapshot: Vector2 = Vector2(0,0)
@onready var timerSnapshot: Timer = $SnapshotTimer
var waitTimeSnapshot: float = EN.snapshotWaitTime

var stopRange: float = EN.stopRange
var stopSpeed: float = 0.06 #closer to 0 the smoother

@onready var timerKnock: Timer = $KnockTimer
var waitTimeKnock: float = 0.2

@onready var timerAttack: Timer = $AttackCooldown
var attackWaitTime: float = EN.attackWaitTime
var attackDelay: float = EN.attackDelay
signal dying
func _ready() -> void:
	$ProgressBar.max_value = MaxEnemyHP
	$ProgressBar.value = EnemyHP
	print(stopRange)

func _physics_process(_delta: float) -> void:
	#print(position.distance_to(Stats.PlayerLocation))
	#print(timerKnock.is_stopped(), timerKnock.time_left)
	if timerKnock.is_stopped():
		if position.distance_to(Stats.PlayerLocation) > stopRange:
			velocity = (playerSnapshot - position).normalized() * SPEED
		elif position.distance_to(Stats.PlayerLocation) < stopRange/2:
			velocity = -(playerSnapshot - position).normalized() * SPEED
		else:
			attack()
			velocity.x = move_toward(velocity.x, 0, SPEED * stopSpeed)
			velocity.y = move_toward(velocity.y, 0, SPEED * stopSpeed)
	move_and_slide() 

func _on_snapshot_timer_timeout() -> void:
	playerSnapshot = Stats.PlayerLocation
	#print(Vector2(playerSnapshot.x - position.x,playerSnapshot.y - position.y),Vector2(playerSnapshot.x - position.x,playerSnapshot.y - position.y).normalized())
	timerSnapshot.start(waitTimeSnapshot)
	
func EnemyDamage(value:float):
	#checks if getting knocked, death check, health change, knock back
	if timerKnock.is_stopped():
		if EnemyHP - value <= 0:
			dying.emit()
			Stats.Demeter+=EN.VitaminDrop
			self.queue_free()
		
		EnemyHP -= value
		$ProgressBar.value = EnemyHP
		
		timerKnock.start(waitTimeKnock)
		velocity = -(Stats.PlayerLocation - position).normalized() * value*15

func attack():
	if timerAttack.is_stopped():
		timerAttack.start(EN.attackDelay)
		await timerAttack.timeout
		
		var newBullet = load(EN.projectileFile).instantiate()
		newBullet.position = position
		newBullet.direction = (Stats.PlayerLocation - position).normalized()
		newBullet.speed = EN.projSpeed
		newBullet.distance = EN.projDistance
		newBullet.damage = EN.projDamage
		newBullet.melee = EN.melee
		get_parent().add_child(newBullet)
		
		timerAttack.start(EN.attackWaitTime)

#func _unhandled_key_input(_event: InputEvent) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#takeDamage(10)
