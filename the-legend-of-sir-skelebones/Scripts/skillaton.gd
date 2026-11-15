extends Control


var eyeConDict: Dictionary = {"HP":"eventual sprite","Speed":"eventual sprite"}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Rise")
	$Head/EyeCon/Label.text = "HP"
	$Head/EyeStat.text = str(int(Stats.PlayerHP))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
