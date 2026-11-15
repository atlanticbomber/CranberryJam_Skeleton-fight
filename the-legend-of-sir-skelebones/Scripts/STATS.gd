extends Node

var MaxPlayerHP: float = 100.0
var PlayerHP: float = MaxPlayerHP

var MaxDemeter: float = 100.0
var Demeter: float = 0.0
var Vitamins: int = 0 

var PlayerLocation: Vector2 = Vector2(0,0)
var Speed: float = 360



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
