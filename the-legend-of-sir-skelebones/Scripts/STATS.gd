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
var Bones:Array = [0,0,0]

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
	"011":false,#Atk+???
	"012":false,#Atk Spd+
	"013":false,#Range
	"021":false,#Range
	"022":false,#AtkSpd
	"0221":false,#Bones
}

var currentActive: WeaponResource = load("res://Resources/Weapon/fist.tres")
var weaponsAquired: int = 0 
signal weaponChange
#signal PlayerHPChange(value:float)

func init_player_stats():
	MaxPlayerHP = 200.0
	PlayerHP = MaxPlayerHP
	PlayerSpeed = 330
	PlayerAttack = 1.0
	skills = {
	"0":true, #origin
	"01":false,#Bone Blade
	"02":false,#Femurder
	"03":false,#Rib Wrecker
	"04":false,#Skelescythe
	"011":false,#Atk+???
	"012":false,#Atk Spd+
	"013":false,#Range
	"021":false,#Range
	"022":false,#AtkSpd
	"0221":false,#Bones
	"031":false,#atk
	"0311":false,#atk
	"032":false,#atkspd
	"041":false,#range
	"042":false,#atkspd
	}
	MaxDemeter = 5
	Demeter = 0.0
	Vitamins = 3
	Vitaminscollected = 0 
	PlayerLevels = [0,0,0]
