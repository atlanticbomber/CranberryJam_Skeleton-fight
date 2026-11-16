extends Button

@onready var line: Line2D = $Line2D
var sprites:Dictionary = {
	"active":"res://Sprites/Skillaton/ActiveNode.png",
	"passive":"res://Sprites/Skillaton/PassiveNode.png",
	"spec":"res://Sprites/Skillaton/SpecNode.png"}
var nodeInfo: Dictionary = {
	"0":{"sprite": sprites["active"],"cost":[0,0,0,0],"name":"Origin","tip":"origin"},
	"01":{"sprite": sprites["active"],"cost":[1,2,0,0],"name":"Bone Blade","tip":"A strong sword made from arm, take this! itʻs dangerous either way"},
	"02":{"sprite": sprites["active"],"cost":[1,0,2,0],"name":"Femurder","tip":"A strong spear made from leg, range is your only friend"},
	"03":{"sprite": sprites["active"],"cost":[1,0,0,2],"name":"Rib Wrecker","tip":"A strong hammer made from rib, your bulk is gone but the smash is still here"},
	"04":{"sprite": sprites["active"],"cost":[1,1,1,1],"name":"Skelescythe","tip":"A strong scyther made from skeleton, let the ring of death surround you"},
	
	"011":{"sprite": sprites["spec"],"cost":[1,1,0,0],"name":"Atk+","tip":"Atk+"},
	"012":{"sprite": sprites["spec"],"cost":[1,1,0,0],"name":"Atk Spd+","tip":"Atk Spd+"},
	"013":{"sprite": sprites["spec"],"cost":[1,1,0,0],"name":"Range+","tip":"Range+"},
	
	"021":{"sprite": sprites["spec"],"cost":[1,0,1,0],"name":"Range+","tip":"Range+"},
	"022":{"sprite": sprites["spec"],"cost":[1,0,1,0],"name":"Atk Spd+","tip":"Atk Spd+"},
	"0221":{"sprite": sprites["spec"],"cost":[1,1,1,1],"name":"Bones+","tip":"Bones+"},
	
	"031":{"sprite": sprites["spec"],"cost":[1,0,0,1],"name":"Atk+","tip":"Atk+"},
	"0311":{"sprite": sprites["spec"],"cost":[1,0,0,2],"name":"Atk++","tip":"Atk++"},
	"032":{"sprite": sprites["spec"],"cost":[1,0,0,1],"name":"Atk Spd+","tip":"Atk Spd++"},
	
	"041":{"sprite": sprites["spec"],"cost":[1,1,0,1],"name":"Atk Spd+","tip":"Range+"},
	"042":{"sprite": sprites["spec"],"cost":[1,0,1,1],"name":"Range+","tip":"Atk+"},
	}
func _ready() -> void:
	#die if theres 3 weapons alr
	if name in "01 02 03 04" and not Stats.skills[name] and Stats.weaponsAquired>2:
		queue_free()
	
	# Visual text
	info()
	if name != "0":
		#print(name.erase(name.length()-1))
		var searchNode = name.erase(name.length()-1)
		
		#if not Stats.skills[searchNode]:
				#visible = false
				
		for node in get_parent().get_children():
			if node.name == searchNode:
				print(node.position)
				line.add_point(node.position-position)
				break
		
func _process(_delta: float) -> void:
	if is_hovered():
		self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		self_modulate = Color(0.737, 0.737, 0.737, 1.0)

func _on_pressed() -> void:
	var price: Array = nodeInfo[name]["cost"]
	if (Stats.Vitamins>=price[0] and Stats.Bones[0]>=price[1] and 
	Stats.Bones[1]>=price[2] and Stats.Bones[2]>=price[3]) and not Stats.skills[name]:
		#lose money
		Stats.skills[name] =  true 
		Stats.Vitamins -= price[0]
		Stats.Bones[0] -= price[1]
		Stats.Bones[1] -= price[2]
		Stats.Bones[2] -= price[3]
		info()
		
		#aquire weapon
		print(get_parent().get_parent().get_parent().get_parent().slots)
		if name == "01":
			get_parent().get_parent().get_parent().get_parent().slots[Stats.weaponsAquired] = load("res://Resources/Weapon/BasicSword.tres")
			Stats.weaponsAquired+=1
			get_parent().get_parent().get_parent().get_parent().slots[Stats.weaponsAquired] = load("res://Resources/Weapon/fist.tres")
		elif name == "02":
			get_parent().get_parent().get_parent().get_parent().slots[Stats.weaponsAquired] = load("res://Resources/Weapon/BasicFemur.tres")
			Stats.weaponsAquired+=1
			get_parent().get_parent().get_parent().get_parent().slots[Stats.weaponsAquired] = load("res://Resources/Weapon/fist.tres")
		elif name == "03":
			get_parent().get_parent().get_parent().get_parent().slots[Stats.weaponsAquired] = load("res://Resources/Weapon/BasicHammer.tres")
			Stats.weaponsAquired+=1
			get_parent().get_parent().get_parent().get_parent().slots[Stats.weaponsAquired] = load("res://Resources/Weapon/fist.tres")
		elif name == "04":
			get_parent().get_parent().get_parent().get_parent().slots[Stats.weaponsAquired] = load("res://Resources/Weapon/BasicSycthe.tres")
			Stats.weaponsAquired+=1
			get_parent().get_parent().get_parent().get_parent().slots[Stats.weaponsAquired] = load("res://Resources/Weapon/fist.tres")
			
			
		#Sword Specs
		elif name == "011":
			var sword:WeaponResource = load("res://Resources/Weapon/BasicSword.tres")
			sword.damage += 10
		elif name == "012":
			var sword:WeaponResource = load("res://Resources/Weapon/BasicSword.tres")
			sword.delay -= 0.1
			sword.cooldown -=0.1
		elif name == "013":
			var sword:WeaponResource = load("res://Resources/Weapon/BasicSword.tres")
			var newShape: CapsuleShape2D= sword.shape
			newShape.height +=100
			sword.shape = newShape
			
		#Femurder Specs
		elif name == "021":
			var femur:WeaponResource = load("res://Resources/Weapon/BasicFemur.tres")
			var newShape: CapsuleShape2D= femur.shape
			newShape.height +=150
			femur.shape = newShape
		elif name == "022":
			var femur:WeaponResource = load("res://Resources/Weapon/BasicFemur.tres")
			femur.delay -= 0.1
			femur.cooldown -=0.1
		
		#Hammer
		elif name == "031":
			var hammer:WeaponResource = load("res://Resources/Weapon/BasicHammer.tres")
			hammer.damage += 10
		elif name == "0311":
			var hammer:WeaponResource = load("res://Resources/Weapon/BasicHammer.tres")
			hammer.damage += 20
		elif name == "032":
			var hammer:WeaponResource = load("res://Resources/Weapon/BasicHammer.tres")
			hammer.delay -= 0.2
			hammer.cooldown -=0.1
			
		#Scythe
		elif name == "041":
			var scythe:WeaponResource = load("res://Resources/Weapon/BasicSycthe.tres")
			scythe.delay -= 0.2
			scythe.cooldown -=0.1
		elif name == "042":
			var scythe:WeaponResource = load("res://Resources/Weapon/BasicSycthe.tres")
			var newShape: CapsuleShape2D= scythe.shape
			newShape.radius +=50
			newShape.height +=100
			scythe.shape = newShape
			
	elif Stats.skills[name]:
		print("bought already")
	else:
		print("cant buy")

func info():
	if name in nodeInfo:
		icon = load(nodeInfo[name]["sprite"])
		text = nodeInfo[name]["name"]
		if not Stats.skills[str(name)]:
			text +="\nVitamins: "+str(nodeInfo[name]["cost"][0])
			text += "\nArms: "+str(nodeInfo[name]["cost"][1]) if (nodeInfo[name]["cost"][1])>0 else ""
			text += "\nLegs: "+str(nodeInfo[name]["cost"][2]) if (nodeInfo[name]["cost"][2])>0 else ""
			text += "\nRibs: "+str(nodeInfo[name]["cost"][3]) if (nodeInfo[name]["cost"][3])>0 else ""
		else:
			text+="\nAquired"
		
		tooltip_text = nodeInfo[name]["tip"]
