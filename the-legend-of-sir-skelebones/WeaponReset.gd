extends Node

var OGsword:WeaponResource
var OGfemur:WeaponResource
var OGhammer:WeaponResource
var OGscythe:WeaponResource

func _ready() -> void:
	OGsword = load("res://Resources/Weapon/BasicSword.tres").duplicate()
	OGfemur = load("res://Resources/Weapon/BasicFemur.tres").duplicate()
	OGhammer = load("res://Resources/Weapon/BasicHammer.tres").duplicate()
	OGscythe = load("res://Resources/Weapon/BasicSycthe.tres").duplicate()
	

func reset():
	var nowSword:WeaponResource= load("res://Resources/Weapon/BasicSword.tres") 
	nowSword.damage = OGsword.damage
	nowSword.delay = OGsword.delay
	nowSword.cooldown = OGsword.cooldown
	nowSword.shape = OGsword.shape
	
	var nowFemur:WeaponResource= load("res://Resources/Weapon/BasicFemur.tres") 
	nowFemur.damage = OGfemur.damage
	nowFemur.delay = OGfemur.delay
	nowFemur.cooldown = OGfemur.cooldown
	nowFemur.shape = OGfemur.shape

	var nowHammer:WeaponResource= load("res://Resources/Weapon/BasicHammer.tres") 
	nowHammer.damage = OGhammer.damage
	nowHammer.delay = OGhammer.delay
	nowHammer.cooldown = OGhammer.cooldown
	nowHammer.shape = OGhammer.shape
	
	var nowScythe:WeaponResource= load("res://Resources/Weapon/BasicSycthe.tres") 
	nowScythe.damage = OGscythe.damage
	nowScythe.delay = OGscythe.delay
	nowScythe.cooldown = OGscythe.cooldown
	nowScythe.shape = OGscythe.shape
