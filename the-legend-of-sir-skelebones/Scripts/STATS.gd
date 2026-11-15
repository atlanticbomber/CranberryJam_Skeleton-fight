extends Node

var MaxPlayerHP: float = 100.0
var PlayerHP: float = MaxPlayerHP
var PlayerSpeed: float = 330
var PlayerAttack: float = 1.0
var PlayerLevels = [0,0,0]

var MaxDemeter: float = 5
var Demeter: float = 0.0
var Vitamins: int = 0 
var Vitaminscollected:int = 0 

var currentScene:String = "Menu"

var PlayerLocation: Vector2 = Vector2(0,0)

func levelUpdate():
	MaxPlayerHP = 100.0 + 50.0*PlayerLevels[0]
	PlayerSpeed = 330.0 + 20.0*PlayerLevels[1]
	PlayerAttack = 1.0 + 0.15*PlayerLevels[2]

var skills:Dictionary = {
	"0":{"?":true,"cost":0}, #origin
	"01":{"?":false,"cost":1},#sword
	"02":{"?":false,"cost":1},#hammer
	"03":{"?":false,"cost":1},#lance
	"04":{"?":false,"cost":1},#scythe
	"011":{"?":false,"cost":1},#i guess upgrade???
	"031":{"?":false,"cost":1},#i guess another upgrade???
}

var currentActive: WeaponResource = load("res://Resources/Weapon/BasicSword.tres")
signal weaponChange
#signal PlayerHPChange(value:float)
