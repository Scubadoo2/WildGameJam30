extends Control

#Main variables
var maxHP = 1
var hp = maxHP

var heart = preload("res://Scenes/UI/Heart.tscn")
var heartWidth
var heartHolder = []
var currentHP = hp

var temp

#Signals
signal GameOver()

# Called when the node enters the scene tree for the first time.
func _ready():
	var temp = $Heart
	heartWidth = (temp.texture.get_width() / 2) * temp.scale.x
	temp.free()
	ChangeMaxHP(maxHP)
	
func ChangeHP(amount):
	hp = int(clamp(hp + amount, 0, maxHP))
	
	if(hp <= 0):
		emit_signal("GameOver", "hp")
		
	UpdateVisual()
	
func ChangeMaxHP(newMax):
	if(newMax <= 0):
		print("ERROR: Hitpoint max can't be at or below 0, got " + String(newMax) + ".")
		return
	
	var difference = maxHP - hp
	maxHP = newMax
	
	hp = int(max(maxHP - difference, 1))
	
	#Getting rid of the old hearts
	for oldHeart in heartHolder:
		oldHeart.queue_free()
		
	heartHolder.clear()
	
	#Adding in the new hearts
	for newIndex in range(0,newMax):
		var newHeart = heart.instance()
		newHeart.move_local_x(heartWidth * newIndex)
		heartHolder.append(newHeart)
		add_child(newHeart)
	
	currentHP = newMax
	print(heartHolder.size())
	ChangeHP(0)

func UpdateVisual():
	
	#Bringing a higher HP down
	while(currentHP > hp):
		currentHP -= 1
		heartHolder[currentHP].set_frame(1)
	
	#Bringing a lowerr HP up
	while(currentHP < hp):
		heartHolder[currentHP].set_frame(0)
		currentHP += 1
	
