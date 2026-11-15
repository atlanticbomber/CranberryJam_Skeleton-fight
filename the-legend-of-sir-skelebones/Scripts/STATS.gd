extends Node

var MaxPlayerHP: float = 200.0
var PlayerHP: float = MaxPlayerHP
var PlayerSpeed: float = 330
var PlayerAttack: float = 1.0
var PlayerLevels = [0,0,0]

var MaxDemeter: float = 5
var Demeter: float = 0.0
var Vitamins: int = 10
var Vitaminscollected:int = 0 
# Arms, Legs, Ribs
var Bones:Array = [10,10,10]

var currentScene:String = "Menu"

var PlayerLocation: Vector2 = Vector2(0,0)

func levelUpdate():
	MaxPlayerHP = 200.0 + 50.0*PlayerLevels[0]
	PlayerSpeed = 330.0 + 20.0*PlayerLevels[1]
	PlayerAttack = 1.0 + 0.15*PlayerLevels[2]

var skills:Dictionary = {
	"0":true, #origin
	"01":false,#Bone Blade
	"02":false,#Femurder
	"03":false,#Rib Wrecker
	"04":false,#Skelescythe
	"011":false,#i guess upgrade???
	"031":false#i guess another upgrade???
}

var currentActive: WeaponResource = load("res://Resources/Weapon/fist.tres")
var weaponsAquired: int = 0 
signal weaponChange
#signal PlayerHPChange(value:float)

func init_player_stats():
	MaxPlayerHP = 100.0
	PlayerHP = MaxPlayerHP
	PlayerSpeed = 330
	PlayerAttack = 1.0
