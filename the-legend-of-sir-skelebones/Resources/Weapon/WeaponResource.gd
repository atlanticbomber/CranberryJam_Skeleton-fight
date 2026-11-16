extends Resource
class_name WeaponResource

@export var name: String = "fist"
@export var shape:CapsuleShape2D
@export var towardsCenter:float = 0 
@export var delay:float = 0.2
@export var cooldown:float = 1.0
@export var damage:float = 10.0
@export var texture:Texture = load("res://Sprites/Skelebro/RealFist.png")
