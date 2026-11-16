extends Node

var MaxPlayerHP: float
var PlayerHP: float 
var PlayerSpeed: float
var PlayerAttack: float 
var PlayerLevels

var MaxDemeter: float 
var Demeter: float 
var Vitamins: int 
var Vitaminscollected:int 
# Arms, Legs, Ribs
var Bones:Array = [10,10,10]

var currentScene:String = "Menu"

var PlayerLocation: Vector2 = Vector2(0,0)

func levelUpdate():
	MaxPlayerHP = 200.0 + 50.0*PlayerLevels[0]
	PlayerSpeed = 330.0 + 20.0*PlayerLevels[1]
	PlayerAttack = 1.0 + 0.15*PlayerLevels[2]

var skills:Dictionary

var currentActive: WeaponResource = load("res://Resources/Weapon/fist.tres")
var weaponsAquired: int = 0 
signal weaponChange
#signal PlayerHPChange(value:float)

func init_player_stats():
	MaxPlayerHP = 200.0
	PlayerHP = MaxPlayerHP
	PlayerSpeed = 330
	PlayerAttack = 1.0
	PlayerLevels = [0,0,0]
	skills = {
	"0":true, #origin
	"01":false,#Bone Blade
	"02":false,#Femurder
	"03":false,#Rib Wrecker
	"04":false,#Skelescythe
	"011":false,#i guess upgrade???
	"031":false#i guess another upgrade???
	}
	MaxDemeter = 5
	Demeter = 0.0
	Vitamins = 10
	Vitaminscollected = 0 
	PlayerLevels = [0,0,0]
