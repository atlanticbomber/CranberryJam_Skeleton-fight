extends Button

@onready var line: Line2D = $Line2D
var sprites:Dictionary = {
	"active":"res://Sprites/Skillaton/ActiveNode.png",
	"passive":"res://Sprites/Skillaton/PassiveNode.png",
	"spec":"res://Sprites/Skillaton/SpecNode.png"}
var nodeInfo: Dictionary = {
	"0":{"sprite": sprites["active"],"cost":[0,0,0,0],"name":"Origin","tip":"origin"},
	"01":{"sprite": sprites["active"],"cost":[1,2,0,0],"name":"Bone Blade","tip":"A strong sword made from arm"},
	"02":{"sprite": sprites["active"],"cost":[1,0,2,0],"name":"Femurder","tip":"A strong spear made from leg"},
	"03":{"sprite": sprites["active"],"cost":[1,0,0,2],"name":"Rib Wrecker","tip":"A strong hammer made from rib"},
	"04":{"sprite": sprites["active"],"cost":[1,1,1,1],"name":"Skelescythe","tip":"A strong scyther made from skeleton"},
	}
func _ready() -> void:
	if name in nodeInfo:
		icon = load(nodeInfo[name]["sprite"])
		text = nodeInfo[name]["name"]+"\nVitamins: "+str(nodeInfo[name]["cost"][0])
		text += "\nArms: "+str(nodeInfo[name]["cost"][1]) if (nodeInfo[name]["cost"][1])>0 else ""
		text += "\nLegs: "+str(nodeInfo[name]["cost"][2]) if (nodeInfo[name]["cost"][2])>0 else ""
		text += "\nRibs: "+str(nodeInfo[name]["cost"][3]) if (nodeInfo[name]["cost"][3])>0 else ""
		tooltip_text = nodeInfo[name]["tip"]
	if name != "0":
		#print(name.erase(name.length()-1))
		var searchNode = name.erase(name.length()-1)
		
		if not Stats.skills[searchNode]["?"]:
				visible = false
				
		for node in get_parent().get_children():
			if node.name == searchNode:
				print(node.position)
				line.add_point(node.position-position)
				break
		
func _process(delta: float) -> void:
	if is_hovered():
		self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		self_modulate = Color(0.737, 0.737, 0.737, 1.0)
