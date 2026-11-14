extends Control

@onready var HealthBar: TextureProgressBar = $Health
@onready var Demeter: TextureProgressBar =  $Demeter

func _ready() -> void:
	#connect("PlayerHPChange",HealthBarChange)
	pass
func _process(_delta: float) -> void:
	Demeter.value = Stats.Demeter
	HealthBar.value = Stats.PlayerHP
	
#func HealthBarChange(value: float):
	#HealthBar.value = Stats.PlayerHP
