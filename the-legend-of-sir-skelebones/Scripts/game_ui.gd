extends Control

@onready var HealthBar: TextureProgressBar = $Health
@onready var Demeter: TextureProgressBar =  $Demeter

@export var slots: Array[WeaponResource] = [null,null,null,null,null,null]
var currentSlot: int = 0 

func _ready() -> void:
	Stats.currentActive = slots[0]

func _process(_delta: float) -> void:
	Demeter.value = Stats.Demeter
	Demeter.max_value = Stats.MaxDemeter
	if Stats.Demeter >= Stats.MaxDemeter:
		Stats.Vitamins += 1
		Stats.Vitaminscollected +=1
		Stats.Demeter = 0 
		Stats.MaxDemeter = floori(5 * (1.2**Stats.Vitaminscollected))
	
	HealthBar.value = Stats.PlayerHP
	HealthBar.max_value = Stats.MaxPlayerHP
	
	$Health/Skull/Label.text = str(Stats.Vitamins)
	

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Slot1") or $Slots/Slot1.button_pressed:
		if slots[0] != null and currentSlot != 0:
			currentSlot = 0
			Stats.currentActive = slots[0]
			Stats.emit_signal("weaponChange")
			#print("slot1",slots[0],Stats.currentActive)
	elif Input.is_action_just_pressed("Slot2") or $Slots/Slot2.button_pressed:
		if slots[1] != null and currentSlot != 1:
			currentSlot = 1
			Stats.currentActive = slots[1]
			Stats.emit_signal("weaponChange")
			#print("slot2",slots[1],Stats.currentActive)
	elif Input.is_action_just_pressed("Slot3") or $Slots/Slot3.button_pressed:
		if slots[2] != null and currentSlot != 2:
			currentSlot = 2
			Stats.currentActive = slots[2]
			Stats.emit_signal("weaponChange")
			#print("slot2",slots[1],Stats.currentActive)
	elif Input.is_action_just_pressed("skillaton"):
		if $CanvasLayer.get_child_count() == 0:
			var newSkillaton = load("res://Scenes/skillaton.tscn").instantiate()
			$CanvasLayer.add_child(newSkillaton)
			get_tree().paused = true
		
	for child in $Slots.get_children():
		child.self_modulate = Color(1.0, 1.0, 1.0, 0.784)
	$Slots.get_child(currentSlot).self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	
		
	

	
#func HealthBarChange(value: float):
	#HealthBar.value = Stats.PlayerHP
