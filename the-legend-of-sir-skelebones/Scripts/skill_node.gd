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
		
		if not Stats.skills[searchNode]:
				visible = false
				
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
		elif name == "02":
			get_parent().get_parent().get_parent().get_parent().slots[Stats.weaponsAquired] = load("res://Resources/Weapon/BasicFemur.tres")
			Stats.weaponsAquired+=1
		elif name == "03":
			get_parent().get_parent().get_parent().get_parent().slots[Stats.weaponsAquired] = load("res://Resources/Weapon/BasicHammer.tres")
			Stats.weaponsAquired+=1
		elif name == "04":
			get_parent().get_parent().get_parent().get_parent().slots[Stats.weaponsAquired] = load("res://Resources/Weapon/BasicSycthe.tres")
			Stats.weaponsAquired+=1
			
	elif Stats.skills[name]:
		print("bought already")
	else:
		print("cant buy")

func info():
	if name in nodeInfo:
		icon = load(nodeInfo[name]["sprite"])
		text = nodeInfo[name]["name"]
		if not Stats.skills[name]:
			text +="\nVitamins: "+str(nodeInfo[name]["cost"][0])
			text += "\nArms: "+str(nodeInfo[name]["cost"][1]) if (nodeInfo[name]["cost"][1])>0 else ""
			text += "\nLegs: "+str(nodeInfo[name]["cost"][2]) if (nodeInfo[name]["cost"][2])>0 else ""
			text += "\nRibs: "+str(nodeInfo[name]["cost"][3]) if (nodeInfo[name]["cost"][3])>0 else ""
		else:
			text+="\nAquired"
		
		tooltip_text = nodeInfo[name]["tip"]
