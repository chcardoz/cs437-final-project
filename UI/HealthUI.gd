extends Control

var health = 4 setget set_health
var max_health = 4 setget set_max_health
onready var healthProgress = $HBoxContainer/ProgressBar

func set_health(value):
	health = clamp(value,0,max_health)
	if healthProgress != null:
		healthProgress.value = health / max_health * 100
	
func set_max_health(value):
	max_health = max(value,1)
	
func _ready():
	self.max_health = PlayerStats.max_health
	self.health = PlayerStats.health
	PlayerStats.connect("on_health_change",self,"set_health")
