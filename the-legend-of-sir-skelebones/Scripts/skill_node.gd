extends Button

@onready var line: Line2D = $Line2D

func _ready() -> void:
	
	
	text = name+"\nCost:"+str(Stats.skills[name]["cost"])
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
