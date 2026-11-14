extends CharacterBody2D

var MaxEnemyHP: float = 100
var EnemyHP: float = MaxEnemyHP

const SPEED = 360.0

var playerSnapshot: Vector2 = Vector2(0,0)
@onready var timerSnapshot: Timer = $SnapshotTimer
var waitTimeSnapshot: float = 0.8

var stopRange: float = 10.0
var stopSpeed: float = 0.06 #closer to 0 the smoother

@onready var timerKnock: Timer = $KnockTimer
var waitTimeKnock: float = 0.2

func _ready() -> void:
	$ProgressBar.max_value = MaxEnemyHP
	$ProgressBar.value = EnemyHP

func _physics_process(_delta: float) -> void:
	#print(position.distance_to(Stats.PlayerLocation))
	#print(timerKnock.is_stopped(), timerKnock.time_left)
	if timerKnock.is_stopped():
		if position.distance_to(Stats.PlayerLocation) > stopRange:
			velocity = (playerSnapshot - position).normalized() * SPEED
		elif position.distance_to(Stats.PlayerLocation) < stopRange/1.3:
			velocity = -(playerSnapshot - position).normalized() * SPEED
		else:
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
			self.queue_free()
		
		EnemyHP -= value
		$ProgressBar.value = EnemyHP
		
		var tempKnockback: float = 1000
		timerKnock.start(waitTimeKnock)
		velocity = -(Stats.PlayerLocation - position).normalized() * tempKnockback

#func _unhandled_key_input(_event: InputEvent) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#takeDamage(10)
