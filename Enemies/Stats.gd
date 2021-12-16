extends Node

#Player stats
export(int) var max_health : int = 1 setget set_max_health
var health : int = max_health setget set_health
var experience = 0 setget set_experience
var experience_total = 0
var experience_required = 0 setget set_experience_required

signal no_health
signal on_health_change(newhealth)
signal on_max_health_change(newMaxHealth)
signal on_experience_change(data)

func set_health(value):
	health = value
	emit_signal("on_health_change",health)
	if health <=0 :
		emit_signal("no_health")
		
		
func set_max_health(value):
	max_health = value
	self.health = min(health,max_health)
	emit_signal("on_max_health_change",max_health)

func set_experience_required(value):
	experience_required = value
	
func set_experience(value):
	experience_total = value
	experience = value
	var growth_data = []
	while experience >= experience_required:
		experience -= experience_required
		growth_data.append([experience_required,experience_required])
		level_up()
	growth_data.append([experience,experience_required])
	emit_signal("on_experience_change",growth_data)

func get_required_exp(value):
	return round(pow(value,1.8)+value*4)
	
func level_up():
	self.max_health += 1
	self.experience_required = get_required_exp(max_health + 1)

func _ready():
	PlayerStats.health = max_health
	PlayerStats.experience = 0
	self.health = max_health
	self.experience = 0
	self.experience_required = get_required_exp(max_health+1)


