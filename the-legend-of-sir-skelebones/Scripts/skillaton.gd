extends Control


var eyeNumDict = ["res://Sprites/Skillaton/1.png"]
var eyeConArray:Array = [
	"res://Sprites/Skillaton/HealthEyecon.png",
	"res://Sprites/Skillaton/SpeedEyecon.png",
	"res://Sprites/Skillaton/AttackEyecon.png"]

#0:HP, 1:Spd, 2:Atk
var eyeCheck:int= 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.changeMusic("Skill")
	$AnimationPlayer.play("Rise")
	await $AnimationPlayer.animation_finished
	eyeStat()
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("skillaton") and not $AnimationPlayer.is_playing():
		$SkillTree.visible = false
		$AnimationPlayer.play("Rise",-1,-1,true)
		await $AnimationPlayer.animation_finished 
		get_tree().paused = false
		print((
	"	HP: "+str(Stats.MaxPlayerHP)+"
	Speed: "+str(Stats.PlayerSpeed))+"
	Atk: "+str(Stats.PlayerAttack))
		Music.changeMusic("Battle")
		queue_free()

func _on_nose_button_pressed() -> void:
	eyeCheck = eyeCheck+1 if eyeCheck<2 else 0
	#print("pressed, now ",eyeCheck)
	eyeStat()

func eyeStat():
	$Head/Eyecon.visible = false
	$Head/NumberEyecon.visible =false
	$Head/Eyecon.texture = load(eyeConArray[eyeCheck])
	$Head/NumberEyecon.texture = load("res://Sprites/Skillaton/"+str(Stats.PlayerLevels[eyeCheck])+".png")
	await get_tree().create_timer(0.2).timeout
	$Head/Eyecon.visible = true
	$Head/NumberEyecon.visible =true
	$AnimationPlayer.play("blink")

func _process(_delta: float) -> void:
	$Ribs/OriginFront/Label.text = "Vitamins: "+str(Stats.Vitamins)+"
	Arms: " + str(Stats.Bones[0])+"
	Legs: " + str(Stats.Bones[1])+"
	Ribs: " + str(Stats.Bones[2])

func _on_number_eye_button_pressed() -> void:
	if Stats.Vitamins>0 and Stats.PlayerLevels[eyeCheck]<9:
		Stats.PlayerLevels[eyeCheck]+=1
		Stats.Vitamins-=1
		Stats.levelUpdate()
		eyeStat()


func _on_button_pressed() -> void:
	if Stats.Vitamins>0:
		Stats.Vitamins-=1
		Stats.PlayerHP+= 0.3*Stats.MaxPlayerHP
		if Stats.PlayerHP > Stats.MaxPlayerHP:
			Stats.PlayerHP = Stats.MaxPlayerHP
