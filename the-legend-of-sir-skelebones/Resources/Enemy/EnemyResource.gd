extends Resource
class_name EnemyResource

@export var maxHP: float = 100.0
@export var speed: float = 360.0
@export var snapshotWaitTime: float = 0.8
@export var stopRange:float = 150.0
@export var attackDelay:float = 0.2
@export var attackWaitTime: float =  1.0
@export var projectileFile: String = "res://Scenes/enemyProjectiles/enemy_projectile.tscn"
@export var VitaminDrop: int = 1
#Projectile Stuff
@export var melee = false
@export var projSpeed: float = 300.0
@export var projDistance: float = 1000.0
@export var projDamage: float = 10.0
