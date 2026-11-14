extends Node

var MaxPlayerHP: float = 100.0
var PlayerHP: float = MaxPlayerHP
var Demeter: float = 100.0
var PlayerLocation: Vector2 = Vector2(0,0)
var currentActive: WeaponResource = load("res://Resources/Weapon/BasicSword.tres")
signal weaponChange
#signal PlayerHPChange(value:float)
